## Understand a domain trough its language

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

## Commands are the verbs of a domain

### Why it matters



## Aslide about machine learning
