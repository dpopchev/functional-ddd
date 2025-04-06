## Composition of types

### Why it matters

- Models the domain in purest form
- Achieve self documenting code
- Enhance IDE support

::: columns

:::: {.column width=30%}

### Simple Types

```python
SolutionId = \
    NewType("SolutionId", str)
```

::::

:::: {.column width=40%}

### Product Types

```python
@dataclass(frozen=True)
class CartesianPoint:
    x: int
    y: int

@dataclass(frozen=True)
class PolarPoint:
    r: int
    phi: int
```

::::

:::: {.column width=30%}

### Sum Types

```python
Point = Union[CartesianPoint,
              PolarPoint]
```

::::

:::

## Functions are also types

### Why it matters

- Type of functions can be used to communicate interface

```python
T = TypeVar('T')
Operation = Callable[[T, T], T]

def wrapper(op: Operation, a: T, b: T) -> T:
    return op(a, b)

# valid syntax
wrapper(lambda a, b: a-b, a, b)
```
### Big picture:

- Type hints shines when using with static type checker
- Allows for self documenting code
- Makes dependencies obvious and easy to fill
