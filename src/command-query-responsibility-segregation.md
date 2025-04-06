## Pushing persistence to the edges

### Why it matters

- Keeps the domain pure and easy to test

::: columns

:::: column

```python
# Define types
LoadSolution = Callable[[SolutionId], Solution]
SaveSolution = Callable[[Solution], None]
```

::::

:::: column

```python
def add_points(load: LoadSolution,
               save: SaveSolution,
               sid: SolutionId,
               ps: SolutionPoints) -> Solution:
    s: Solution = load(sid)

    updaed_s = solution(ps + s.points)

    save(updated_s)

    return s
```

::::

:::

## Persistence mechanism is implementation detail

### Why it matters

- Decoupling concerns, i.e. allow easy testing or change of write model

::: columns

:::: column

```python
class UnitOfWorkImplementation(ContextManager):
    ...
    def load(self,
             sid: SolutionId) -> Optional[Solution]:
        return self.solutions.get(sid)

    def save(self, s: Solution) -> None:
        self.solutions.add(s)
    ...
```
::::

:::: column

```python
with UnitOfWorkImplementation() as uow:
    return add_points(uow.load, uow.read,...)

### or for testing

s = add_points(lambda _: Solution(),
               lambda _: None,...)
```

::::
:::

## Generalization with command handlers

### Why it matters

- Commands are data structures to handle change of state
- Events are output of aggregate state changes

::: columns

:::: column

```python
@dataclass(frozen=True)
class AddPoints:
    solution_id: SolutionId
    points: SolutionPoints

@dataclass(frozen=True)
class PointsAdded:
    solution_id: SolutionId

COMMAND_HANDLER = {
    AddPoints: handle_add_points,
}
```
::::

:::: column

```python
def handle_add_points(load: LoadSolution,
                      save: SaveSolution,
                      cmd: AddPoints) -> PointsAdded:
    s = load(cmd.solution_id)
    updated_s = add_points(s, cmd.points)
    save(updaed_s)
    return PointsAdded(updated_s.id)
```

::::
:::

## Separated view model

### Why it matters:

- Reading is de-coupled from writing
- Implement using optimized code, i.e. `SQL`
