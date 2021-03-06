﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;
using System.Data.Entity.ModelConfiguration;
using TuiTche.Dominio;
using TuiTche.Repositorio.EF.Mapping;
using TwiTche.Repositorio.EF.Mapping;

namespace TuiTche.Repositorio.EF
{
    public class BancoDeDados : DbContext
    {
        public BancoDeDados()
            : base("TUITCHE")
        {

        }

        public DbSet<Usuario> Usuario { get; set; }
        public DbSet<Hashtag> Hashtag { get; set; }
        public DbSet<Publicacao> Publicacao{ get; set; }
        public DbSet<Pontuacao> Pontuacao { get; set; }
        public DbSet<Curtir> Curtir { get; set; }
        public DbSet<PalavraGauderia> PalavraGauderia { get; set; }
        public DbSet<Compartilhar> Compartilhar { get; set; }
        public DbSet<Comentario> Comentario { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Configurations.Add(new UsuarioMap());
            modelBuilder.Configurations.Add(new HashtagMap());
            modelBuilder.Configurations.Add(new PublicacaoMap());
            modelBuilder.Configurations.Add(new PontuacaoMap());
            modelBuilder.Configurations.Add(new CurtirMap());
            modelBuilder.Configurations.Add(new CompartilharMap());
            modelBuilder.Configurations.Add(new PalavraGauderiaMap());
            modelBuilder.Configurations.Add(new ComentarioMap());
            base.OnModelCreating(modelBuilder);
        }
    }
}
