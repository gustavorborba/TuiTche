﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TuiTche.Dominio
{
    public class Pontuacao : EntidadeBase
    {
        public int PontuacaoTotal { get; set; }
        public Usuario UsuarioPontuacao { get; set; }
    }
}
