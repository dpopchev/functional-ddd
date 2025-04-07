## Understand a domain trough its language

### Why it matters

- What do we want?, *everything being done*
- When do we want it?, *now*
- How we are doing it today?, *simply...; \[workflow with more meanders than a river\]*

::: columns

:::: column

### Strategic design

- bounded context
- context mapping

::::

:::: column

### Tactical design

- value objects
- entities
- aggregates

::::

:::

### Bottom line

Domain Driven Design is approach towards building shared mental model between
domain expert and development team. It offers a path to collaboration.

### What is next

Case study -- Black Holes. Just for the sake of it.

## Black hole premier

::: columns

:::: column

### Equations to solve

![Differential system](data/images/black-hole-system.png)
![Coupling Function](data/images/black-hole-coupling-function.png){width=50%}


### Bottom line

- Modified equations are *very hard* to expand, solve and approximate
- The expanded system is hardly coupled and numerically unstable
- Computations are both time and resources demanding

::::

:::: column

### Bifurcation

![Mass vs Radius](data/images/black-hole-bifurcation.png)

::::

:::

## Modelling a black hole properties

### Gravity is a domain

Astrophysicists are interested into compact objects observable properties
, e.g. mass/radius of black hole or neutron star. Having those calculated can help
rule out theories using experimental data deviation.

::: columns

:::: {.column width=30%}

### Solution point

```python
...
@dataclass(frozen=True)
class BlackHoleSolutionPoint:
    rh: NonNegativeFloat
    m: NonNegativeFloat
    d: float
    phiH: float
    beta: float
    kappa: float
    lambda2: float
    phi0: float
    theory: str
...
```
::::

:::: {.column width=70%}

### Solution

```python
...
BlackHoleSolutionPoints = Iterable[BlackHoleSolutionPoint]
class Solution:
    def __init__(self,
                 points: Optional[BlackHoleSolutionPoints] = None):
        self._id: Final[str] = self._make_id()
        ...
    @property
    def points(self) -> DataFrame:
        ...
    @property
    def id(self) -> str:
        return self._id
...
```

::::

:::

### What is next

- `SolutionPoint` fits value object definition; Is `Solution` an entity?

## Black Hole Solution is an aggregate

### Why it matters

- Aggregate is a cluster of related objects, responsible to keep their
consistency.
- `Solution` is the order set of `SolutionPoints` that share same independent
parameters, e.g. `beta, phi0, theory`.
- `Solution` has monotonic, i.e. either increasing or decreasing, components,
e.g. `m, rh`.

```python
...
BlackHoleSolutionPoints = Iterable[BlackHoleSolutionPoint]
class Solution:
    def __init__(self,
                 points: Optional[BlackHoleSolutionPoints] = None):
        ...
        if points:
            self._points = [p for p in points] if self._check(points)
    def _check(p: BlackHoleSolutionPoints) -> bool:
        return all(map(c(p) for c in self._checks))
...
```

### Bottom Line

- Aggregate enforces consistency and invariants
- Aggregate is atomic unit of persistence/database transaction/data transfer.

## Modify aggregates with functions

### Why it matters

- Changing aggregate state likely has different rules, than maintaining consistency,
e.g. adding existing point is not desired.
- Extract update logic into a function
- Domain experts, likely, already have a term for making the change anyway.

```python
def add_points(s: Solution, ps: BlackHoleSolutionPoints) -> Solution:
    # assume O(1) belonging point time complexity
    # assume best case scenario of O(nlogn) sorting

    if ps in s:
        raise ValueError

    return Solution(ps + s.points)
```
## Respect the domain boundaries

### Why it matters

- Add what *feels* as belonging to the domain.
- Think how you organize the cutlery drawer
  - you put forks, knifes, spoons, etc; things needed to eat
  - you do not put put power drill, despite being handy to fix stuff around kitchen

### Big picture

- Instead of putting everything in one place, e.g. `Solution` and machine
learning models using solutions, separate. Likely the `MachineModel` will have
its own lifecycle and persistence.
- Rule of thumb: if it takes too much time to explain, likely it is not the place to put it.

```bash
src/gravity_package/
                    solutions/...
                    machine_learning/...
```
