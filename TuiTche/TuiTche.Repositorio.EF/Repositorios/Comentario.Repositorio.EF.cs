﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TuiTche.Dominio;
using TuiTche.Dominio.Interfaces;
using TuiTche.Repositorio.EF;

namespace TuiTche.Repositorio.EF
{
    public class ComentarioRepositorio : IComentarioRepositorio
    {
        public int Salvar(Comentario comentario)
        {
            using (var db = new BancoDeDados())
            {
                db.Entry(comentario).State = System.Data.Entity.EntityState.Added;
                return db.SaveChanges();
            }
        }

        public Comentario BuscarPorId(int id)
        {
            using (var db = new BancoDeDados())
            {
                return db.Comentario.Include("Usuario").Include("Publicacao").FirstOrDefault(u => u.Id == id);
            }
        }
    }
}
