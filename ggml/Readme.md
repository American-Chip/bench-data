
# Guide

To reproduce results above, you first need to launch EC2 instances.

| Machine | OS | Kernel version | Region | Compiler | CPU | vCPU | Memory (GiB) | #Threads for benchmark |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| m7g.8xlarge | Ubuntu 22.04.2 LTS | 6.2.0-1010-aws | us-east-1 | Gcc 11.4.0 | Arm-based AWS Graviton3 processors | 32 | 64 | 1-16 |
| m6i.8xlarge | Ubuntu 22.04.2 LTS | 6.2.0-1010-aws | us-east-1 | Gcc 11.4.0 | Intel | 32 | 64 | 1-16 |
| m6.8xlarge | Ubuntu 22.04.2 LTS | 6.2.0-1010-aws | us-east-1 | Gcc 11.4.0 | AMD | 32 | 64 | 1-16 |


Assume you have already installed haco

```
git clone https://github.com/ggerganov/ggml.git
git clone https://github.com/American-Chip/bench-data.git
cd ggml
git checkout 95b559dbae6a25b2a7e26ab5989c1538387225e9
cp -r ../bench-data/ggml/scripts/ bench
cd bench
mkdir install_log
./haco -t "bash build.sh" -b "bash benchmark.sh"
```

After finish running, data will be stored in `benchmark.log`, it's not directly in the `csv` format



Data used for visualization in the blog are in the `data` folder

# Disable SIMD
To build SIMD-Disabled version for ARM

```
git clone https://github.com/ggerganov/ggml.git
git clone https://github.com/American-Chip/bench-data.git
cd ggml
git checkout 95b559dbae6a25b2a7e26ab5989c1538387225e9
cp -r ../bench-data/ggml/scripts/ bench
patch src/ggml.c < ../bench-data/ggml/disable_simd_on_arm.patch
cd bench
mkdir install_log
./haco -t "bash build.sh" -b "bash benchmark.sh"
```

# Benchmark.log
HACO uses architecture-relevant flags to tune the applications, below are the results from two flags

* `-O3 -DNDEBUG` (Native Build)
* `-Ofast -flto -mcpu=neoverse-512tvb` (HACO)

```

Threads: 1, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: -Ofast -flto -mcpu=neoverse-512tvb | Average time: 464.27333333333333333333
Threads: 2, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: -Ofast -flto -mcpu=neoverse-512tvb | Average time: 241.55333333333333333333
Threads: 3, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: -Ofast -flto -mcpu=neoverse-512tvb | Average time: 169.54666666666666666666
Threads: 4, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: -Ofast -flto -mcpu=neoverse-512tvb | Average time: 132.36666666666666666666
Threads: 5, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: -Ofast -flto -mcpu=neoverse-512tvb | Average time: 110.81333333333333333333
Threads: 6, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: -Ofast -flto -mcpu=neoverse-512tvb | Average time: 94.22666666666666666666
Threads: 7, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: -Ofast -flto -mcpu=neoverse-512tvb | Average time: 85.64333333333333333333
Threads: 8, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: -Ofast -flto -mcpu=neoverse-512tvb | Average time: 77.52333333333333333333
Threads: 9, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: -Ofast -flto -mcpu=neoverse-512tvb | Average time: 72.04333333333333333333
Threads: 10, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: -Ofast -flto -mcpu=neoverse-512tvb | Average time: 67.35333333333333333333
Threads: 11, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: -Ofast -flto -mcpu=neoverse-512tvb | Average time: 63.83000000000000000000
Threads: 12, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: -Ofast -flto -mcpu=neoverse-512tvb | Average time: 66.60666666666666666666
Threads: 13, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: -Ofast -flto -mcpu=neoverse-512tvb | Average time: 67.00000000000000000000
Threads: 14, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: -Ofast -flto -mcpu=neoverse-512tvb | Average time: 66.37666666666666666666
Threads: 15, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: -Ofast -flto -mcpu=neoverse-512tvb | Average time: 65.01666666666666666666
Threads: 16, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: -Ofast -flto -mcpu=neoverse-512tvb | Average time: 63.37666666666666666666
Threads: 1, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: default | Average time: 1166.43666666666666666666
Threads: 2, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: default | Average time: 588.12666666666666666666
Threads: 3, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: default | Average time: 393.89666666666666666666
Threads: 4, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: default | Average time: 296.91333333333333333333
Threads: 5, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: default | Average time: 239.36666666666666666666
Threads: 6, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: default | Average time: 200.07666666666666666666
Threads: 7, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: default | Average time: 172.52333333333333333333
Threads: 8, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: default | Average time: 151.37333333333333333333
Threads: 9, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: default | Average time: 135.46000000000000000000
Threads: 10, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: default | Average time: 122.54333333333333333333
Threads: 11, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: default | Average time: 112.10666666666666666666
Threads: 12, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: default | Average time: 103.44333333333333333333
Threads: 13, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: default | Average time: 96.09333333333333333333
Threads: 14, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: default | Average time: 89.73333333333333333333
Threads: 15, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: default | Average time: 84.33333333333333333333
Threads: 16, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: default | Average time: 79.65000000000000000000
Threads: 1, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: default | Average time: 4546.52666666666666666666
Threads: 2, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: default | Average time: 2273.97666666666666666666
Threads: 3, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: default | Average time: 1518.55000000000000000000
Threads: 4, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: default | Average time: 1139.68000000000000000000
Threads: 5, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: default | Average time: 913.10333333333333333333
Threads: 6, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: default | Average time: 761.34666666666666666666
Threads: 7, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: default | Average time: 653.65333333333333333333
Threads: 8, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: default | Average time: 571.90000000000000000000
Threads: 9, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: default | Average time: 509.59666666666666666666
Threads: 10, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: default | Average time: 458.82333333333333333333
Threads: 11, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: default | Average time: 417.77333333333333333333
Threads: 12, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: default | Average time: 383.41333333333333333333
Threads: 13, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: default | Average time: 354.58333333333333333333
Threads: 14, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: default | Average time: 329.38000000000000000000
Threads: 15, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: default | Average time: 308.20333333333333333333
Threads: 16, Intrinsics 0, SuperOptimizer 0 With gcc, Optimization Flag: default | Average time: 288.83000000000000000000

```

Run it with HACO will put all the results in `benchmark.log` from different flags in HACO, so that you can know which flag gives the best performance

# install_log

build log are automatically stored under `install_log` folder

