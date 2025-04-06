## Understand a domain trough its language

### Why it matters

- What do we want?, *everything being done*
- When do we want it?, *now*
- How we do it?, *simply...*; workflow with more meanders than a river

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
- repositories

::::

:::

### Bottom line

DDD offers recipes to achieve domain expert and development team collaboration.

### What is next

Explore the domain of solutions for black holes.

## Modelling a black hole properties

### Gravity is a domain

Astrophysicists are interested into compact objects observable parameters
, e.g. mass of black hole or neutron star. Having those calculated can help
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

- Changing aggregate state likely has more rules, than maintaining consistency,
e.g. adding new existing point is not desired.
- Extract update logic into a function
- Domain experts, likely, already have a term for making the change anyway.

```python
def add_points(s: Solution, ps: BlackHoleSolutionPoints) -> Solution:
    # assume O(1) association point complexity O(n) ope
    # compared with O(nlogn) sorting that can back fire

    if ps in s:
        raise ValueError

    return Solution(ps + s.points)
```
## Respect the domain boundaries

### Why it matters

- Add what feels as belonging to the domain.
- Think how you organize the cutlery drawer; you won't put your dirty power
drill there would you? Regardless how handy it might be for fixing stuff around
the kitchen.
- It is always useful to reach out to the domain experts -- if it takes too much
  time to explain, likely it is not the place to put it.

### Big picture

- Instead of putting everything in one place, e.g. `Solution` and machine
learning models using solutions, separate. Likely the `MachineModel` will have
its own lifecycle and persistence.

```bash
src/gravity_package/
                    solutions/...
                    machine_learning/...
```
