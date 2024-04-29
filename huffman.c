#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define TAM_ASCII 256

//Cria tipo Node
typedef struct Node
{
  char caracter;
  int frequencia;
  struct Node* esq;
  struct Node* dir;
  struct Node* next;
}Node;

//Cria tipo Lista
typedef struct Lista
{
  struct Node* head;
  int tamanho;
}Lista;

Lista lista; //Inicializa lista
//----------------------------Funções da lista encadeada-------------------------
void inicializarLista() 
{
  lista.head = NULL;
  lista.tamanho = 0;
}

void addNodeLista(Node *node)
{
  node->next = NULL;
  if (lista.head == NULL)
    {
      lista.head = node;
    }
  else if(node->frequencia < lista.head->frequencia)
  {
    node->next = lista.head;
    lista.head = node;
  }
  else
  {
    Node *pAnda = lista.head;
    while(pAnda->next && pAnda->next->frequencia <= node->frequencia)
      {
        pAnda = pAnda->next;
      }

    node->next = pAnda->next;
    pAnda->next = node;
  }
  lista.tamanho++;
}

void preenche_lista(int vetor_frequencia[])
{
  Node *new_node;
  for(int i = 0; i < TAM_ASCII; i++)
    {
      if(vetor_frequencia[i] != 0)
      {
        new_node = malloc(sizeof(Node));
        if(new_node)
        {
          new_node->caracter = i;
          new_node->frequencia = vetor_frequencia[i];
          new_node->dir = NULL;
          new_node->esq = NULL;
          new_node->next = NULL;
          addNodeLista(new_node);
        }
        else
        {
          printf("Erro na alocação de memória");
          break;
        }
      }
    }
}

void show_Lista()
{
  Node* pAnda = lista.head;
  while(pAnda->next != NULL)
    {
      printf("%c: %d\n", pAnda->caracter, pAnda->frequencia);
      pAnda = pAnda->next;
    }
  printf("%c: %d\n", pAnda->caracter, pAnda->frequencia);
}
//----------------------------Funções da árvore-----------------------------

Node* remove_head()
{
  Node *aux = NULL;

  if(lista.head)
  {
    aux = lista.head;
    lista.head = aux->next;
    aux->next = NULL;
    lista.tamanho--;
  }
  return aux;
}

Node* create_tree()
{
  Node* first, *second, *new_node;
  while(lista.tamanho > 1)
    {
      first = remove_head();
      second = remove_head();
      new_node = malloc(sizeof(Node));

      if(new_node)
      {
        new_node->caracter = '+';
        new_node->frequencia = first->frequencia + second->frequencia;
        new_node->esq = first;
        new_node->dir = second;
        new_node->next = NULL;
        addNodeLista(new_node);
      }
      else
      {
        printf("Erro ao alocar memória ao criar a árvore");
        break;
      }
      
    }
  return lista.head;
}

void show_tree(Node* raiz, int tam)
{
  if(raiz->esq == NULL && raiz->dir == NULL)
    printf("Folha: %c\tAltura: %d\n", raiz->caracter, tam);
  else
  {
    show_tree(raiz->esq, tam + 1);
    show_tree(raiz->dir, tam + 1);
  }
}

//-----------------------------Dicionário--------------------------
int altura_arvore(Node *raiz)
{
  int esq, dir;
  if(raiz == NULL)
    return -1;
  else
  {
    esq = altura_arvore(raiz->esq) + 1;
    dir = altura_arvore(raiz->dir) + 1;

    if(esq > dir)
      return esq;
    else
      return dir;
  }
}

char** aloca_dict(int colunas)
{
  char **dict;

  dict = malloc(sizeof(char*) * TAM_ASCII);

  for(int i = 0; i < TAM_ASCII; i++)
    {
      dict[i] = calloc(colunas, sizeof(char));
    }
  return dict;
}

void gera_dict(char **dict, Node *raiz, char *caminho, int colunas)
{
  char esquerda[colunas], direita[colunas];
  if(raiz->esq == NULL && raiz->dir == NULL)
    strcpy(dict[raiz->caracter], caminho);
  else
  {
    strcpy(esquerda, caminho);
    strcpy(direita, caminho);

    strcat(esquerda, "0");
    strcat(direita, "1");
    gera_dict(dict, raiz->esq, esquerda, colunas);
    gera_dict(dict, raiz->dir, direita, colunas);
  }
}

void show_dict(char **dict)
{
  for(int i = 0; i < TAM_ASCII; i++)
    {
      if(strlen(dict[i]) != 0)
      printf("%3d: %s\n", i, dict[i]);
    }
}

//----------------------Compactar-------------------------
int get_strlen(char **dict, char *texto)
{
  int i = 0, tam = 0;
  while(texto[i] != '\0')
    {
      tam += strlen(dict[texto[i]]);
      i++;
    }
  return tam + 1;
}


char* codifica(char** dict, char *texto)
{
  int i = 0;
  int tam = get_strlen(dict, texto);
  char *codigo = calloc(tam, sizeof(char));

  while(texto[i] != '\0')
    {
      strcat(codigo, dict[texto[i]]);
      i++;
    }
  return codigo;
  
}

//----------------------Descompactar--------------------
char* decodifica(char *texto, Node *raiz)
{
  int i = 0;
  Node *aux = raiz;
  char temp[2];
  char *decodificado = calloc(strlen(texto), sizeof(char));
  
  while(texto[i] != '\0')
    {
      if(texto[i] == '0')
        aux = aux->esq;
      else
        aux = aux->dir;

      if(aux->esq == NULL && aux->dir == NULL)
      {
        temp[0] = aux->caracter;
        temp[1] = '\0';
        strcat(decodificado, temp);
        aux = raiz;
      }
      i++;
    }
  return decodificado;
}

//-----------------------------Main--------------------------
void zera_vetor(int vetor[], int n)
{
  for(int i = 0; i < n; i++)
    vetor[i] = 0;
}

int main(void) 
{
  int vetor_frequencia[TAM_ASCII];
  zera_vetor(vetor_frequencia, TAM_ASCII);
  Node *tree;
  int colunas;
  char **dicionario;
  char *texto;
  char *texto_codificado, *texto_decodificado;
  
  FILE *arq;
  arq = fopen("texto.txt", "r");
  if (arq == NULL)  // Se houve erro na abertura
    {
       printf("Problemas na abertura do arquivo\n");
       return 0;
    }
  char caractere;
  while ((caractere = fgetc(arq)) != EOF) 
  {
    vetor_frequencia[caractere]++;
  }

  int tamanho;
  fseek(arq, 0, SEEK_END);
  tamanho = ftell(arq);
  rewind(arq);

  // Alocar memória para armazenar o conteúdo do arquivo
  texto = (char *)malloc(tamanho * sizeof(char));

  // Verificar se a alocação de memória foi bem-sucedida
  if (texto == NULL) {
      perror("Erro ao alocar memória");
      fclose(arq);
      return 1;
  }

  // Ler o conteúdo do arquivo para a string
  fread(texto, 1, tamanho, arq);

  // Adicionar um caractere nulo ao final para formar uma string válida em C
  texto[tamanho] = '\0';

  // Fecha o arquivo
  fclose(arq);
  preenche_lista(vetor_frequencia);
  tree = create_tree();
  colunas = altura_arvore(tree) + 1;
  dicionario = aloca_dict(colunas);
  gera_dict(dicionario, tree, "", colunas);

  printf("\nTexto compactado:\n");
  texto_codificado = codifica(dicionario, texto); // Vai pro out.txt
  printf("%s\n", texto_codificado);

  printf("\nTexto descompactado:\n");
  texto_decodificado = decodifica(texto_codificado, tree);
  printf("%s", texto_decodificado);

  return 0;
  
}