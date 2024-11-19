# bsMLST

Make bootstraps for MLST

## Installation

The conda environment has been encoded in Pixi.

```bash
pixi install
# activate the environment
pixi shell
```

## Usage

Make the bootstrap profiles

```bash
bootstraps=100
CPUS=1

mkdir bsProfiles

seq 1 $bootstraps | xargs -P $CPUS -n 1 bash -c '
  echo -ne . >&2
  zcat calls_core_standard.tsv.gz | ./bsProfile.pl | sed 's/?/123456789/g' > bsProfiles/$0.tsv
' && \
  echo >&2
```

Make grapetree trees from the BS profiles

```bash
seq 1 $bootstraps | xargs -P $CPUS -n 1 bash -c '
  echo -ne . >&2
  profile=bsProfiles/$0.tsv
  numLines=$(cut -f 2- $profile | sort | uniq | wc -l)
  if [[ "$numLines" -lt 3 ]]; then
    echo "SKIP: No diversity found in $profile" >&2
    exit
  fi
  grapetree --profile $profile > bsProfiles/$0.dnd || echo "ERROR with $profile" >&2
' && \
  echo >&2

```

Make a grapetree from original profiles

```bash
zcat calls_core_standard.tsv.gz > calls.tsv 
grapetree --profile calls.tsv -n 1 > grapetree.dnd
```

- or -

Add bootstraps to the tree using `gotree`.

```bash
gotree compute support fbp -b <(cat bsProfiles/*.dnd) < grapetree.dnd > grapetree.bs.dnd
```
