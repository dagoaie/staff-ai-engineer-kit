# DeepEval

DeepEval es un framework Python de evaluación para aplicaciones LLM. Trata evaluaciones como tests: permite medir un resultado end-to-end, un componente RAG o la trayectoria de un agente dentro del suite de pruebas del proyecto.

## Instalación por proyecto

No lo instales globalmente. Declara la dependencia y ejecuta siempre con el entorno bloqueado del repositorio:

```sh
uv add --dev deepeval
uv run deepeval test run evals/test_rag.py
```

Los jueces LLM introducen coste y variabilidad. Fija el modelo evaluador, registra su versión y usa umbrales revisados contra una muestra humana. No conviertas un score de juez en verdad de producto sin calibrarlo.

## Uso diario

Un test de comportamiento con una métrica explícita:

```python
from deepeval import assert_test
from deepeval.metrics import GEval
from deepeval.test_case import LLMTestCase, SingleTurnParams

def test_answer_is_grounded():
    metric = GEval(
        name="Grounded answer",
        criteria="La respuesta solo afirma hechos presentes en el contexto.",
        evaluation_params=[
            SingleTurnParams.ACTUAL_OUTPUT,
            SingleTurnParams.RETRIEVAL_CONTEXT,
        ],
        threshold=0.8,
    )
    assert_test(
        LLMTestCase(
            input="<pregunta>",
            actual_output="<respuesta de la aplicación>",
            retrieval_context=["<fragmento recuperado>"],
        ),
        [metric],
    )
```

## Combinado con

- [Promptfoo](promptfoo.md): comparte corpus, baseline y scorecard. Promptfoo es el gate declarativo transversal; DeepEval aporta tests Python y métricas de componente o trayectoria.
- [Docling](docling.md): prueba la cadena de RAG desde documentos convertidos hasta la respuesta, no solo el último prompt.
- [Ficha de modelo](../../../playbook/templates/model-card-template.md): registra modelo evaluador, rúbrica, umbral y limitaciones del juez.

## Referencias

- [DeepEval: evaluación](https://deepeval.com/docs/evaluation-introduction)
- [DeepEval: métricas](https://deepeval.com/docs/metrics-introduction)
