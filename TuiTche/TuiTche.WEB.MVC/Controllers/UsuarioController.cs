﻿using Services.CriptografiaService;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;
using TuiTche.Dominio;
using TuiTche.Repositorio.EF;
using TuiTche.WEB.MVC.Models;

namespace TuiTche.WEB.MVC.Controllers
{
    public class UsuarioController : Controller
    {
        UsuarioRepositorio repositorio = new UsuarioRepositorio();
        // GET: Usuario
        public ActionResult index()
        {
            return View("CadastrarUsuario");
        }

        public ActionResult CadastrarUsuario(UsuarioModel model)
        {
            bool usuarioRepetido = repositorio.VerificarEmailEUsernameRepetido(model.Email, model.Username);
            
            if(usuarioRepetido)
            {
                TempData["Mensagem"] = "Usuário e/ou Email já se encontram na base de dados";
                return View("CadastrarUsuario", model);
            }

            if (ModelState.IsValid)
            {
                string file = Path.GetFileName(model.FotoPerfil.FileName);
                string local = Path.Combine(Server.MapPath("~/Content/img-upload/"), file);
                model.FotoPerfil.SaveAs(local);
                CriptografiaService cripografia = new CriptografiaService();
                Usuario usuario = new Usuario(model.Username)
                {
                    NomeCompleto = model.NomeCompleto,
                    Senha = cripografia.Criptografar(model.Senha),
                    Email = model.Email,
                    SexoUsuario = model.Sexo,
                    Foto = local
                };
                repositorio.CadastrarUsuario(usuario);
                TempData["Mensagem"] = "Jogo Criado com Sucesso!";
                return RedirectToAction("Index", "Login");
            }
            TempData["Mensagem"] = "Ocorreu os seguintes erros: ";
            return View("CadastrarUsuario", model);
        }
    }
}