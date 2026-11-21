# Gerenciador de Chamados CLI em Lua

Utilitário leve de linha de comando escrito em **Lua** para registrar, listar e encerrar chamados técnicos ou tarefas diárias com persistência local em arquivo.

## Funcionalidades
- Registro de novos chamados com status (`ABERTO` ou `CONCLUIDO`).
- Listagem organizada no terminal.
- Encerramento de chamados por identificador numérico.

## Como executar
```bash
lua chamados.lua adicionar "Verificar integracao de notas fiscais"
lua chamados.lua listar
lua chamados.lua concluir 1