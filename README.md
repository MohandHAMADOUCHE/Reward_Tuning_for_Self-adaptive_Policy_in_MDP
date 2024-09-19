# Reward Tuning for Self-adaptive Policy in MDP Based Distributed Decision-Making to Ensure a Safe Mission Planning

This project focuses on reward tuning in Markov Decision Processes (MDPs) to enable self-adaptive policies in distributed decision-making, ensuring safe mission planning. The method is validated on a UAV tracking mission case study.

## Table of Contents

- [Overview](#overview)
- [Installation](#installation)
- [Results](#results)
- [Contributing](#contributing)
- [License](#license)

## Overview

Markov Decision Processes (MDPs) are a standard model for sequential decision-making under uncertainty, typically involving a single agent making decisions. However, in fields like robotics, multiple actions may need to be executed simultaneously by different agents. The complexity of missions often requires the decomposition of an MDP into sub-MDPs, which can lead to conflicts between agents performing concurrent actions. Furthermore, system or sensor failures may introduce risks during missions, such as UAV crashes caused by battery depletion.

This project presents a new method to prevent behavior conflicts in distributed decision-making and emphasizes action selection to ensure system safety. The approach recomputes rewards dynamically, taking into account antagonistic actions and thresholds on transition functions, to promote actions that guarantee mission safety. The method is validated using a UAV tracking mission case study, where rewards are recomputed to avoid conflicts and ensure constraint satisfaction.

## Installation

### Requirements

- MATLAB (any version supporting base MATLAB functions)

### Getting Started

1. Clone the project repository:
    ```bash
    git clone https://github.com/MohandHAMADOUCHE/Reward_Tuning_for_Self-adaptive_Policy_in_MDP.git
    cd Reward_Tuning_for_Self-adaptive_Policy_in_MDP
    ```

2. Choose the appropriate test based on the case:

   - **2.1. To test the MDP example**: Navigate to the folder `"0. MDP Example - UAV control"` and run the MATLAB file `MDP_Racing_UAV.m`:
     ```matlab
     cd '0. MDP Example - UAV control'
     run('MDP_Racing_UAV.m')
     ```

   - **2.2. To test reward tuning at the UAV level**: Navigate to the folder `"1. At UAV level"` and run the MATLAB file `main.m`:
     ```matlab
     cd '1. At UAV level'
     run('main.m')
     ```

   - **2.3. To test reward tuning at the swarm level**: Navigate to the folder `"2. At SWARM level"` and run the MATLAB file `main.m`:
     ```matlab
     cd '2. At SWARM level'
     run('main.m')
     ```

## Results

The results of the simulations are detailed in the following paper: [Reward Tuning for Self-adaptive Policy in MDP Based Distributed Decision-Making to Ensure a Safe Mission Planning](https://ieeexplore.ieee.org/abstract/document/9476691). You can access the full results and methodology in the published paper.

## Contributing

We welcome contributions! Please follow these steps:

1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Submit a pull request with a detailed explanation of your changes.

## License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.

Please cite this work in your publications:

```bibtex
@inproceedings{hamadouche2020reward,
  title={Reward tuning for self-adaptive policy in mdp based distributed decision-making to ensure a safe mission planning},
  author={Hamadouche, Mohand and Dezan, Catherine and Branco, Kalinka RLJC},
  booktitle={2020 50th Annual IEEE/IFIP International Conference on Dependable Systems and Networks Workshops (DSN-W)},
  pages={78--85},
  year={2020},
  organization={IEEE}
}
```
