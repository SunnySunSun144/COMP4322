# COMP4322 Link State Routing (LSR) Protocol Implementation

A complete Java implementation of the Link State Routing protocol with Dijkstra's shortest path algorithm, supporting both interactive single-step and batch compute-all modes with a graphical user interface.

## Project Overview

This project implements a router emulation system that:
- Parses Link State Advertisement (LSA) files to build network topology
- Executes Dijkstra's shortest path algorithm from a specified source node
- Supports two execution modes:
  - **Single-Step (SS)**: Interactive mode with step-by-step visualization
  - **Compute-All (CA)**: Batch mode for rapid computation
- Provides both command-line and GUI interfaces
- Supports dynamic network topology modifications

## Features

### Mandatory Features
✅ **LSA File Parsing**: Reads weighted network topology from text files
✅ **Dijkstra's Algorithm**: Computes shortest paths from source node
✅ **Path Reconstruction**: Shows complete paths (e.g., A>C>D>E)
✅ **Dual Execution Modes**: Single-step interactive and compute-all batch modes
✅ **Command-Line Interface**: Full CLI support with argument parsing

### Optional Features
✅ **Graphical User Interface**: Full Java Swing GUI with:
  - Network topology visualization
  - Interactive mode selection
  - Real-time result display
  - Step-by-step navigation
  
✅ **Dynamic Topology Management**:
  - Add/remove nodes
  - Add/remove links
  - Persistent file saving

## Quick Start

### Build
```bash
cd src
javac *.java
```

### Run GUI
```bash
java -cp . LSRComputeGUI
```

### Run GUI (Host X11 Forwarding)
```bash
./scripts/run-gui-host-x11.sh
```

### Run GUI (Browser via noVNC)
```bash
./scripts/run-gui-novnc.sh
```

Then open:
```text
http://127.0.0.1:6080/vnc.html
```

### Run CLI - Compute-All
```bash
java -cp . LSRCompute ../data/routes.lsa A CA
```

### Run CLI - Single-Step
```bash
java -cp . LSRCompute ../data/routes.lsa A SS
```

## File Structure

```
COMP4322/
├── src/
│   ├── Graph.java                  # Network topology representation
│   ├── DijkstraAlgorithm.java     # Shortest path algorithm
│   ├── LSAFileParser.java         # File I/O
│   ├── LSRCompute.java            # CLI main program
│   └── LSRComputeGUI.java         # GUI interface
├── data/
│   └── routes.lsa                  # Sample network topology
└── README.md                        # This file
```

## Usage

### GUI Mode (Recommended)
1. Run `java -cp . LSRComputeGUI`
2. Click "Load File" to select an LSA file
3. Choose source node from dropdown
4. Click "Single Step" for interactive mode or "Compute All" for batch
5. Manage topology with Add/Remove nodes and links

For containers where direct X11 is not available, use `./scripts/run-gui-novnc.sh` and connect in the browser.

### CLI Mode
```bash
java -cp . LSRCompute <file.lsa> <source_node> [SS|CA]
```

Arguments:
- `<file.lsa>` - Path to the LSA file
- `<source_node>` - Starting node (e.g., 'A')
- `[SS|CA]` - Execution mode (optional, defaults to CA)
  - `SS` = Single-Step (interactive)
  - `CA` = Compute-All (batch)

## LSA File Format

```
# Comments start with #
NodeA: NodeB:cost NodeC:cost ...
NodeB: NodeA:cost ...
```

Example:
```
A: B:5 C:3 D:5
B: A:5 C:4 E:3 F:2
C: A:3 B:4 D:1 E:6
D: A:5 C:1 E:3
E: B:3 C:6 D:3 F:5
F: B:2 E:5
```

## Sample Output

### Compute-All Mode
```
=== Compute-All Mode ===

Source A:
B: Path: A>B Cost: 5
C: Path: A>C Cost: 3
D: Path: A>C>D Cost: 4
E: Path: A>C>D>E Cost: 7
F: Path: A>B>F Cost: 7
```

### Single-Step Mode
```
=== Single-Step Mode ===
Found C: Path: A>C Cost: 3 [press any key to continue]
Found D: Path: A>C>D Cost: 4 [press any key to continue]
[... more steps ...]

=== Summary ===
Source A:
[summary table]
```

## Classes

- **Graph.java**: Network topology representation with adjacency list
- **DijkstraAlgorithm.java**: Shortest path algorithm with step-by-step support
- **LSAFileParser.java**: LSA file parsing and writing
- **LSRCompute.java**: Command-line interface
- **LSRComputeGUI.java**: Graphical user interface with Swing

## Features Implemented

✅ Mandatory:
- LSA file parsing with format validation
- Dijkstra's algorithm implementation
- Path reconstruction and display
- Single-step and compute-all modes
- Command-line interface

✅ Bonus:
- Full Java Swing GUI
- Dynamic topology management
- Network visualization
- File persistence

## Testing

Sample network with 6 nodes is included in `data/routes.lsa`.

To test from different source nodes:
```bash
java -cp . LSRCompute ../data/routes.lsa B CA
java -cp . LSRCompute ../data/routes.lsa E SS
```

## Error Handling

The program handles:
- Missing or invalid files
- Invalid source nodes
- Malformed LSA format
- Invalid cost values
- Unreachable nodes

## Code Quality

- Clean, readable code with JavaDoc comments
- Proper separation of concerns
- Comprehensive error handling
- Object-oriented design principles