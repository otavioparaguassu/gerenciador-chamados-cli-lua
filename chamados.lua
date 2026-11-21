local ARQUIVO_DADOS = "chamados.db"

local function carregar_chamados()
    local lista = {}
    local arquivo = io.open(ARQUIVO_DADOS, "r")
    if not arquivo then
        return lista
    end

    for linha in arquivo:lines() do
        local status, descricao = linha:match("^(%u+)|(.+)$")
        if status and descricao then
            table.insert(lista, { status = status, descricao = descricao })
        end
    end
    arquivo:close()
    return lista
end

local function salvar_chamados(lista)
    local arquivo = assert(io.open(ARQUIVO_DADOS, "w"))
    for _, item in ipairs(lista) do
        arquivo:write(string.format("%s|%s\n", item.status, item.descricao))
    end
    arquivo:close()
end

local comando = arg[1]

if comando == "adicionar" then
    local descricao = arg[2]
    if not descricao or descricao == "" then
        print("Informe a descricao do chamado.")
        os.exit(1)
    end
    local lista = carregar_chamados()
    table.insert(lista, { status = "ABERTO", descricao = descricao })
    salvar_chamados(lista)
    print(string.format("Chamado #%d registrado.", #lista))

elseif comando == "listar" then
    local lista = carregar_chamados()
    if #lista == 0 then
        print("Nenhum chamado registrado.")
        os.exit(0)
    end
    for i, item in ipairs(lista) do
        print(string.format("#%d [%s] %s", i, item.status, item.descricao))
    end

elseif comando == "concluir" then
    local indice = tonumber(arg[2])
    local lista = carregar_chamados()
    if not indice or not lista[indice] then
        print("Identificador de chamado invalido.")
        os.exit(1)
    end
    lista[indice].status = "CONCLUIDO"
    salvar_chamados(lista)
    print(string.format("Chamado #%d marcado como CONCLUIDO.", indice))

else
    print("Uso: lua chamados.lua [adicionar <texto> | listar | concluir <id>]")
end