```bash
micromamba create -n mistral-env python=3.11
micromamba activate mistral-env
pip install vllm sentencepiece

python -m vllm.entrypoints.openai.api_server \
  --model TheBloke/Mistral-7B-Instruct-v0.2-GPTQ \
  --quantization gptq \
  --port 8000 \
  --max-model-len 8192 \
  --dtype float16
```


