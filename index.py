# Importa a classe Flask do módulo flask
from flask import Flask  

# Cria uma instância da aplicação Flask
app = Flask(__name__)  

# Define a rota para a URL raiz ('/')
@app.route('/')
def home():
    # Retorna uma mensagem simples
    return "Hello World!"  

# Define a rota para a URL '/contatos'
@app.route('/contatos')
def peteca():
    # Retorna uma mensagem simples
    return "Diga o que você quer agora!"  

# Verifica se o script está sendo executado diretamente
if __name__ == '__main__':
    # Inicia o servidor Flask em modo debug
    app.run(debug=True)  
