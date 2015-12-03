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

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Configurations.Add(new UsuarioMap());
            modelBuilder.Configurations.Add(new HashtagMap());
            modelBuilder.Configurations.Add(new PublicacaoMap());
            base.OnModelCreating(modelBuilder);
        }
    }
}
