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
  zcat calls_core_standard.csv.gz | ./bsProfile.pl > bsProfiles/$0.csv
'
echo >&2
```

Make grapetree trees from the BS profiles

Make a grapetree from original profiles

Add bootstraps to the tree using `gotree`.
