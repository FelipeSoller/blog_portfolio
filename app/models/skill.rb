class Skill < ApplicationRecord
  include Placeholder # chama módulo placeholder concern criado para gerar imagens.
  validates_presence_of :title, :percent_utilized

  # after_initialize -> É chamado sempre antes do método de ação new.
  # set_defaults -> É o método que irá atribuir valores padrão aos atributos chamados.
  after_initialize :set_defaults

  def set_defaults
    # ||= -> Para este caso, significa que se ao criarmos uma skill e não adicionarmos a respectiva imagen ao badge, será atribudo valor específico. Caso contrário, o valore atribuído será o indicado no formulário.
    # Placeholder.image_generator(height: 600, width: 400) -> Chama método criado para gerar imagens
    self.badge ||= Placeholder.image_generator(height: 250, width: 250)
  end
end
