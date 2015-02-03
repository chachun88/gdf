#!/usr/bin/python
# -*- coding: UTF-8 -*-

'''
Created on 25/02/2013

@author: Yi Chun
'''
from basehandler import BaseHandler
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from tornado.options import options
from random import randrange
import hashlib
from tornado.options import define, options
import sendgrid

from globals import url_local

class EnviarClaveHandler(BaseHandler):
    def post(self):
        email = self.get_argument("email")
        if(len(email) > 0):
            usuario = self.db.user.find_one({"mail":email,"tipo":"registrado"})
            if usuario:
                clave = str(randrange(100))
                clave = hashlib.md5(clave).hexdigest()[:6]
                self.db.user.update({"_id":usuario["_id"]},{"$set":{"password":clave}})
                
                # if lptranslate("lang") == "es":
                Email(usuario["mail"], str(usuario["_id"]), clave)
                # elif lptranslate("lang") == "en":
                #     EmailEn(usuario["mail"], str(usuario["_id"]), clave)
                    
                self.redirect("/")
            else:
                self.write("Usuario no se encuentra registrado")
        else:
            self.write("Ingrese email por favor")
            
def Email(to, userid, clave, name=""):
      
    fromaddr = options.email  
    toaddrs = to  
    msg = MIMEMultipart('alternative')
    msg['Subject'] = "Restablecimiento de clave de la cuenta Giani da Firenze"
    msg['From'] = "Giani da Firenze " + "<" + fromaddr + ">"
    msg['To'] = toaddrs  
      
      
    # Credentials (if needed)  
    username = options.user  
    password = options.password

    html = """\
    <html xmlns=""><head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="initial-scale=1.0"> 
        <meta name="format-detection" content="telephone=no">
        <link href="http://fonts.googleapis.com/css?family=Roboto:300,100,400" rel="stylesheet" type="text/css">
        <style type="text/css">


        /* Resets: see reset.css for details */
        .ReadMsgBody { width: 100%; background-color: #ffffff;}
        .ExternalClass {width: 100%; background-color: #ffffff;}
        .ExternalClass, .ExternalClass p, .ExternalClass span, .ExternalClass font, .ExternalClass td, .ExternalClass div {line-height:100%;}
        html{width: 100%; }
        body {-webkit-text-size-adjust:none; -ms-text-size-adjust:none; }
        body {margin:0; padding:0;}
        table {border-spacing:0;}
        img{display:block !important;}

        table td {border-collapse:collapse;}
        .yshortcuts a {border-bottom: none !important;}


        html, body { background-color: #ffffff; margin: 0; padding: 0; }
        img { height: auto; line-height: 100%; outline: none; text-decoration: none; display: block;}
        br, strong br, b br, em br, i br { line-height:100%; }
        h1, h2, h3, h4, h5, h6 { line-height: 100% !important; -webkit-font-smoothing: antialiased; }
        h1 a, h2 a, h3 a, h4 a, h5 a, h6 a { color: blue !important; }
        h1 a:active, h2 a:active,  h3 a:active, h4 a:active, h5 a:active, h6 a:active { color: red !important; }
        /* Preferably not the same color as the 300 header link color.  There is limited support for psuedo classes in email clients, this was added just for good measure. */
        h1 a:visited, h2 a:visited,  h3 a:visited, h4 a:visited, h5 a:visited, h6 a:visited { color: purple !important; }
        /* Preferably not the same color as the 300 header link color. There is limited support for psuedo classes in email clients, this was added just for good measure. */  
        table td, table tr { border-collapse: collapse; }
        .yshortcuts, .yshortcuts a, .yshortcuts a:link,.yshortcuts a:visited, .yshortcuts a:hover, .yshortcuts a span {
        color: black; text-decoration: none !important; border-bottom: none !important; background: none !important;
        } /* Body text color for the New Yahoo.  This example sets the font of Yahoo's Shortcuts to black. */
        /* This most probably won't work in all email clients. Don't include <code _tmplitem="406" > blocks in email. */

        code {
          white-space: 300;
          word-break: break-all;
        }
        span a {
          text-decoration: none !important;
        }

        a{
          text-decoration: none !important;
        }

        /*mailChimp class*/
        .default-edit-image{
          height:20px;
        }

        .nav-ul{
          margin-left:-23px !important;
          margin-top:0px !important;
          margin-bottom:0px !important;
        }



        /* 

        main color = #d05d68

        second color = #6a232c

        background color = #ecebeb


        */


        img{height:auto !important;}

          td[class="image-270px"] img{
            width:270px !important;
            height:auto !important;
            max-width:270px !important;
          }
          td[class="image-170px"] img{
            width:170px !important;
            height:auto !important;
            max-width:170px !important;
          }
          td[class="image-185px"] img{
            width:185px !important;
            height:auto !important;
            max-width:185px !important;
          }
          td[class="image-124px"] img{
            width:124px !important;
            height:auto !important;
            max-width:124px !important;
          }
          table[class="container2"]{
            width: 100%!important; 
            float:none !important;

          }


        @media only screen and (max-width: 640px){
          body{
            width:auto!important;
          }

          table[class="container"]{
            width: 100%!important;
            padding-left: 20px!important; 
            padding-right: 20px!important; 
          }



          td[class="image-270px"] img{
            width:100% !important;
            height:auto !important;
            max-width:100% !important;
          }
          td[class="image-170px"] img{
            width:100% !important;
            height:auto !important;
            max-width:100% !important;
          }
          td[class="image-185px"] img{
            width:185px !important;
            height:auto !important;
            max-width:185px !important;
          }
          td[class="image-124px"] img{
            width:100% !important;
            height:auto !important;
            max-width:100% !important;
          }



          td[class="image-100-percent"] img{
            width:100% !important;
            height:auto !important;
            max-width:100% !important;
          }

          td[class="small-image-100-percent"] img{
            width:100% !important;
            height:auto !important;
          }

          table[class="full-width"]{
            width:100% !important;
          }

          table[class="full-width-text"]{
            width:100% !important;
             background-color:#ffffff;
             padding-left:20px !important;
             padding-right:20px !important;
          }

          table[class="full-width-text2"]{
            width:100% !important;
             background-color:#ffffff;
             padding-left:20px !important;
             padding-right:20px !important; 
          }

          table[class="col-2-3img"]{
            width:50% !important;
            margin-right: 20px !important;
          }
            table[class="col-2-3img-last"]{
            width:50% !important;
          }


          table[class="col-2-footer"]{
            width:55% !important;
            margin-right:20px !important;
          }

          table[class="col-2-footer-last"]{
            width:40% !important;
          }


          table[class="col-2"]{
            width:47% !important;
            margin-right:20px !important;
          }

          table[class="col-2-last"]{
            width:47% !important;
          }

          table[class="col-3"]{
            width:29% !important;
            margin-right:20px !important;
          }

          table[class="col-3-last"]{
            width:29% !important;
          }

          table[class="row-2"]{
            width:50% !important;
          }

          td[class="text-center"]{
             text-align: center !important;
           }

          /* start clear and remove*/
          table[class="remove"]{
            display:none !important;
          }

          td[class="remove"]{
            display:none !important;
          }
          /* end clear and remove*/

          table[class="fix-box"]{
            padding-left:20px !important;
            padding-right:20px !important;
          }
          td[class="fix-box"]{
            padding-left:20px !important;
            padding-right:20px !important;
          }

          td[class="font-resize"]{
            font-size: 18px !important;
            line-height: 22px !important;
          }

          table[class="space-scale"]{
            width:100% !important;
            float:none !important;
          }

            table[class="clear-align-640"]{
            float:none !important;
          }


        }



        @media only screen and (max-width: 479px){
          body{
            font-size:10px !important;
          }

         table[class="container"]{
            width: 100%!important;
            padding-left: 10px!important; 
            padding-right:10px!important; 
          }

           table[class="container2"]{
            width: 100%!important; 
            float:none !important;

          }

          td[class="full-width"] img{
            width:100% !important;
            height:auto !important;
            max-width:100% !important;
            min-width:124px !important;
          }


          td[class="image-270px"] img{
            width:100% !important;
            height:auto !important;
            max-width:100% !important;
            min-width:124px !important;
          }
          td[class="image-170px"] img{
            width:100% !important;
            height:auto !important;
            max-width:100% !important;
            min-width:124px !important;
          }
          td[class="image-185px"] img{
            width:185px !important;
            height:auto !important;
            max-width:185px !important;
            min-width:124px !important;
          }
          td[class="image-124px"] img{
            width:100% !important;
            height:auto !important;
            max-width:100% !important;
            min-width:124px !important;
          }

          

          td[class="image-100-percent"] img{
            width:100% !important;
            height:auto !important;
            max-width:100% !important;
            min-width:124px !important;
          }
          td[class="small-image-100-percent"] img{
            width:100% !important;
            height:auto !important;
            max-width:100% !important;
            min-width:124px !important;
          }

          table[class="full-width"]{
            width:100% !important;
          }

          table[class="full-width-text"]{
            width:100% !important;
             background-color:#ffffff;
             padding-left:20px !important;
             padding-right:20px !important;
          }

          table[class="full-width-text2"]{
            width:100% !important;
             background-color:#ffffff;
             padding-left:20px !important;
             padding-right:20px !important;
          }

          table[class="col-2-footer"]{
            width:100% !important;
            margin-right:0px !important;
          }

          table[class="col-2-footer-last"]{
            width:100% !important;
          }



          table[class="col-2"]{
            width:100% !important;
            margin-right:0px !important;
          }

          table[class="col-2-last"]{
            width:100% !important;
           
          }

          table[class="col-3"]{
            width:100% !important;
            margin-right:0px !important;
          }

          table[class="col-3-last"]{
            width:100% !important;
           
          }

            table[class="row-2"]{
            width:100% !important;
          }


          table[id="col-underline"]{
            float: none !important;
            width: 100% !important;
            border-bottom: 1px solid #eee;
          }

          td[id="col-underline"]{
            float: none !important;
            width: 100% !important;
            border-bottom: 1px solid #eee;
          }

          td[class="col-underline"]{
            float: none !important;
            width: 100% !important;
            border-bottom: 1px solid #eee;
          }



           /*start text center*/
          td[class="text-center"]{
            text-align: center !important;

          }

          div[class="text-center"]{
            text-align: center !important;
          }
           /*end text center*/



          /* start  clear and remove */

          table[id="clear-padding"]{
            padding:0 !important;
          }
          td[id="clear-padding"]{
            padding:0 !important;
          }
          td[class="clear-padding"]{
            padding:0 !important;
          }
          table[class="remove-479"]{
            display:none !important;
          }
          td[class="remove-479"]{
            display:none !important;
          }
          table[class="clear-align"]{
            float:none !important;
          }
          /* end  clear and remove */

          table[class="width-small"]{
            width:100% !important;
          }

          table[class="fix-box"]{
            padding-left:0px !important;
            padding-right:0px !important;
          }
          td[class="fix-box"]{
            padding-left:0px !important;
            padding-right:0px !important;
          }
            td[class="font-resize"]{
            font-size: 14px !important;
          }

          td[class="increase-Height"]{
            height:10px !important;
          }
          td[class="increase-Height-20"]{
            height:20px !important;
          }

        }
        @media only screen and (max-width: 320px){
          table[class="width-small"]{
            width:125px !important;
          }
          img[class="image-100-percent"]{
            width:100% !important;
            height:auto !important;
            max-width:100% !important;
            min-width:124px !important;
          }

        }
        </style>



        </head>

        <body style="font-size:12px; font-family:Roboto,Open Sans,Roboto,Open Sans, Arial,Tahoma, Helvetica, sans-serif; background-color:#ffffff; ">

        <!--start 100 wrapper (white background) -->
        <table width="100%" id="mainStructure" border="0" cellspacing="0" cellpadding="0" style="background-color:#ecebeb;">  


           <!--START VIEW ONLINE AND ICON SOCAIL -->
          <tbody>
           <!--END VIEW ONLINE AND ICON SOCAIL-->






            <!--START TOP NAVIGATION ​LAYOUT-->
          <tr>
            <td valign="top">
              <table width="100%" align="center" border="0" cellspacing="0" cellpadding="0">


              <!-- START CONTAINER NAVIGATION -->
              <tbody><tr>
                <td align="center" valign="top">
                  
                  <!-- start top navigation container -->
                  <table width="600" align="center" border="0" cellspacing="0" cellpadding="0" class="container">
                    
                    <tbody><tr>
                      <td valign="top">
                          

                        <!-- start top navigaton -->
                        <table width="560" align="center" border="0" cellspacing="0" cellpadding="0" class="full-width">

                          <!-- start space -->
                          <tbody><tr>
                            <td valign="top" height="20">
                            </td>
                          </tr>
                          <!-- end space -->

                          <tr>
                            <td valign="middle">
                            
                            <table align="left" border="0" cellspacing="0" cellpadding="0" class="container2">
                             
                              <tbody><tr>
                                <td align="center" valign="top">
                                   <a href="#"><img src="http://giani.ondev.today/static/images/giani-logo-2-gris-260x119.png" width="250" style="max-width:250px;" alt="Logo" border="0" hspace="0" vspace="0"></a>
                                </td>
                              
                              </tr>


                                <!-- start space -->
                                <tr>
                                  <td valign="top" class="increase-Height-20">

                                  </td>
                                </tr>
                                <!-- end space -->

                            </tbody></table>

                            <!--start content nav -->
                            <!--end content nav -->

                           </td>
                         </tr>

                          <!-- start space -->
                          <tr>
                            <td valign="top" height="20">
                            </td>
                          </tr>
                          <!-- end space -->

                       </tbody></table>
                       <!-- end top navigaton -->
                      </td>
                    </tr>
                  </tbody></table>
                  <!-- end top navigation container -->

                </td>
              </tr>
              

               <!-- END CONTAINER NAVIGATION -->
          
              </tbody></table>
            </td>
          </tr>
           <!--END TOP NAVIGATION ​LAYOUT-->



        <!-- START HEIGHT SPACE 20PX LAYOUT-1 -->
         <tr>
           <td valign="top" align="center" class="fix-box">
             <table width="600" height="20" align="center" border="0" cellspacing="0" cellpadding="0" style="background-color: #ffffff;" class="full-width">
               <tbody><tr>
                 <td valign="top" height="20">  
                   </td>
               </tr>
             </tbody></table>
           </td>
         </tr>
         <!-- END HEIGHT SPACE 20PX LAYOUT-1-->


         <!-- START LAYOUT-1/1 --> 

         <tr>
           <td align="center" valign="top" class="fix-box">

             <!-- start  container width 600px --> 
             <table width="600" align="center" border="0" cellspacing="0" cellpadding="0" class="container" style="background-color: #ffffff; ">


               <tbody><tr>
                 <td valign="top">

                   <!-- start container width 560px --> 
                   <table width="540" align="center" border="0" cellspacing="0" cellpadding="0" class="full-width" bgcolor="#ffffff" style="background-color:#ffffff;">


                     <!-- start text content --> 
                     <tbody><tr>
                       <td valign="top">
                         <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
                           <tbody><tr>
                             <td valign="top" width="auto" align="center">
                               <!-- start button -->                         
                               <table border="0" align="center" cellpadding="0" cellspacing="0">
                                 <tbody><tr>
                                   <td width="auto" align="center" valign="middle" height="28" style=" background-color:#ffffff; border:1px solid #ececed; background-clip: padding-box; font-size:18px; font-family:Roboto,Open Sans, Arial,Tahoma, Helvetica, sans-serif; text-align:center;  color:#a3a2a2; font-weight: 300; padding-left:18px; padding-right:18px; ">

                                     <span style="color: #a3a2a2; font-weight: 300;">
                                       <a href="#" style="text-decoration: none; color: #a3a2a2; font-weight: 300;">
                                       HOLA <span style="color: #FEBEBD; font-weight: 300;"></span>
                                       </a>
                                     </span>
                                   </td>
                                 </tr>
                               </tbody></table>
                               <!-- end button -->   
                              </td>
                           </tr>



                         </tbody></table>
                       </td>
                     </tr>
                     <!-- end text content --> 


                   </tbody></table>
                   <!-- end  container width 560px --> 
                 </td>
               </tr>
             </tbody></table>
             <!-- end  container width 600px --> 
           </td>
         </tr>

         <!-- END LAYOUT-1/1 --> 


         <!-- START LAYOUT-1/2 --> 

          <tr>
           <td align="center" valign="top" class="fix-box">

             <!-- start  container width 600px --> 
             <table width="600" align="center" border="0" cellspacing="0" cellpadding="0" class="container" style="background-color: #ffffff; ">


               <tbody><tr>
                 <td valign="top">

                   <!-- start container width 560px --> 
                   <table width="540" align="center" border="0" cellspacing="0" cellpadding="0" class="full-width" bgcolor="#ffffff" style="background-color:#ffffff;">


                     <!-- start text content --> 
                     <tbody><tr>
                       <td valign="top">
                         <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
                           

                           <!-- start text content --> 
                           <tbody><tr>
                             <td valign="top">
                               <table border="0" cellspacing="0" cellpadding="0" align="center">
                                 

                                 <!--start space height --> 
                                 <tbody><tr>
                                   <td height="15"></td>
                                 </tr>
                                 <!--end space height --> 

                                 <tr>
                                   <td style="font-size: 13px; line-height: 22px; font-family:Roboto,Open Sans,Arial,Tahoma, Helvetica, sans-serif; color:#a3a2a2; font-weight:300; text-align:center; ">

                                     
                                       Cambiar tu contraseña es simple. Por favor usa el siguiente link {name}
                                     

                                   </td>
                                 </tr>

                                <!--start space height --> 
                                 <tr>
                                   <td height="15"></td>
                                 </tr>
                                 <!--end space height --> 

                               

                               </tbody></table>
                             </td>
                           </tr>
                           <!-- end text content -->

                            <tr>
                             <td valign="top" width="auto" align="center">
                               <!-- start button -->                         
                               <table border="0" align="center" cellpadding="0" cellspacing="0">
                                 <tbody><tr>
                                   <td width="auto" align="center" valign="middle" height="32" style=" background-color:#FEBEBD;  border-radius:5px; background-clip: padding-box;font-size:13px; font-family:Roboto,Open Sans, Arial,Tahoma, Helvetica, sans-serif; text-align:center;  color:#ffffff; font-weight: 300; padding-left:18px; padding-right:18px; ">

                                     <span style="color: #ffffff; font-weight: 300;">
                                       <a href="http://localhost:8502/auth/nuevaclave/620" style="text-decoration: none; color: #FFFFFF; font-weight: 300;">
                                        link
                                       </a>
                                     </span>
                                   </td>

                                   <!-- start space width -->
                                    <td valign="top">
                                      <table width="20" border="0" align="center" cellpadding="0" cellspacing="0">
                                        <tbody><tr>
                                          <td valign="top">
                                            &nbsp;
                                          </td>
                                        </tr>
                                      </tbody></table>
                                    </td>
                                    <!--end space width -->

                                 </tr>
                               </tbody></table>
                               <!-- end button -->   
                              </td>

                           </tr>

                         </tbody></table>
                       </td>
                     </tr>
                     <!-- end text content --> 

                    <!--start space height --> 
                   <tr>
                     <td height="20"></td>
                   </tr>
                   <!--end space height --> 


                   </tbody></table>
                   <!-- end  container width 560px --> 
                 </td>
               </tr>
             </tbody></table>
             <!-- end  container width 600px --> 
           </td>
         </tr>

         <!-- END LAYOUT-1/2 --> 

        <!-- START LAYOUT-9 --> 

         <tr>
           <td align="center" valign="top" class="fix-box">

             <!-- start  container width 600px --> 
             <table width="600" align="center" border="0" cellspacing="0" cellpadding="0" class="container" style="background-color: #ffffff; border-bottom:1px solid #c7c7c7; border-top:1px solid #c7c7c7;">

              <!--start space height --> 
               <tbody><tr>
                 <td height="20" valign="top"></td>
               </tr>
               <!--end space height --> 

               <tr>
                 <td valign="top">

                   <!-- start container width 560px --> 
                   <table width="560" align="center" border="0" cellspacing="0" cellpadding="0" class="full-width" bgcolor="#ffffff" style="background-color:#ffffff;">




                   <!-- start heading -->               
                   <tbody><tr>     
                     <td valign="top">
                       <table width="100%" border="0" cellspacing="0" cellpadding="0" align="left">
                         <tbody><tr>
                           
                        
                           <td align="left" style="font-size: 18px; line-height: 22px; font-family:Roboto,Open Sans, Arial,Tahoma, Helvetica, sans-serif; color:#555555; font-weight:300; text-align:left;">
                             <span style="color: #555555; font-weight:300;">
                               <a href="#" style="text-decoration: none; color: #555555; font-weight: 300;">Contraseña antigua : zxbN82AO</a>
                             </span>
                           </td>

                         </tr>
                       </tbody></table>
                     </td>
                   </tr>
                   <!-- end heading -->  

                    <!--start space height --> 
                     <tr>
                       <td height="15"></td>
                     </tr>
                     <!--end space height --> 
                    
                    <!-- start text content -->
                     <tr>
                       <td valign="top">
                         <table border="0" cellspacing="0" cellpadding="0" align="left">
                           

                           <tbody><tr>
                             <td style="font-size: 13px; line-height: 22px; font-family:Roboto,Open Sans,Arial,Tahoma, Helvetica, sans-serif; color:#a3a2a2; font-weight:300; text-align:left; ">
                              
                                 Gracias.

                             </td>
                           </tr>


                         </tbody></table>
                       </td>
                       
                     </tr>

                     <!-- end text content -->

                     <!--start space height --> 
                     <tr>
                       <td height="15"></td>
                     </tr>
                     <!--end space height --> 

                     <!--start space height --> 
                     <tr>
                       <td height="20" valign="top"></td>
                     </tr>
                     <!--end space height --> 

         

                   </tbody></table>
                   <!-- end  container width 560px --> 
                 </td>
               </tr>
             </tbody></table>
             <!-- end  container width 600px --> 
           </td>
         </tr>

         <!-- END LAYOUT-9 --> 



          








            <!--START FOOTER LAYOUT-->
          <tr>
            <td valign="top">
              <table width="100%" align="center" border="0" cellspacing="0" cellpadding="0">


              <!-- START CONTAINER  -->
              <tbody><tr>
                <td align="center" valign="top">
                  
                  <!-- start footer container -->
                  <table width="600" align="center" border="0" cellspacing="0" cellpadding="0" class="container">
                    
                    <tbody><tr>
                      <td valign="top">
                          

                        <!-- start footer -->
                        <table width="560" align="center" border="0" cellspacing="0" cellpadding="0" class="full-width">

                          <!-- start space -->
                          <tbody><tr>
                            <td valign="top" height="20">
                            </td>
                          </tr>
                          <!-- end space -->

                          <tr>
                            <td valign="middle">
                            
                            <table align="left" border="0" cellspacing="0" cellpadding="0" class="container2">
                             
                              <tbody><tr>
                                <td align="center" valign="top">
                                   <a href="#"><img src="http://giani.ondev.today/static/images/giani-logo-2-gris-260x119.png" width="114" style="max-width:114px;" alt="Logo" border="0" hspace="0" vspace="0"></a>
                                </td>
                              
                              </tr>

                                <!-- start space -->
                                <tr>
                                  <td valign="top" class="increase-Height-20">
                                  </td>
                                </tr>
                                <!-- end space -->

                            </tbody></table>

                           </td>
                         </tr>

                          <!-- start space -->
                          <tr>
                            <td valign="top" height="20">
                            </td>
                          </tr>
                          <!-- end space -->

                       </tbody></table>
                       <!-- end footer -->
                      </td>
                    </tr>
                  </tbody></table>
                  <!-- end footer container -->

                </td>
              </tr>
              

               <!-- END CONTAINER  -->
          
              </tbody></table>
            </td>
          </tr>
           <!--END FOOTER ​LAYOUT-->



           <!--  START FOOTER COPY RIGHT -->

        <tr>
          <td align="center" valign="top" style="background-color:#FEBEBD;">
            <table width="600" align="center" border="0" cellspacing="0" cellpadding="0" class="container" style="background-color:#FEBEBD;">
              <tbody><tr>
                <td valign="top">
                  <table width="560" align="center" border="0" cellspacing="0" cellpadding="0" class="container" style="background-color:#FEBEBD;">

                      <!--start space height -->                      
                      <tbody><tr>
                        <td height="10"></td>
                      </tr>
                      <!--end space height --> 

                    <tr>
                      <!-- start COPY RIGHT content -->  
                      <td valign="top" style="font-size: 13px; line-height: 22px; font-family:Roboto,Open Sans, Arial,Tahoma, Helvetica, sans-serif; color:#ffffff; font-weight:300; text-align:center; ">
                       GIANI DA FIRENZE 2014 ®
                      </td>
                      <!-- end COPY RIGHT content --> 
                    </tr>

                      <!--start space height -->                      
                      <tr>
                        <td height="10"></td>
                      </tr>
                      <!--end space height --> 


                  </tbody></table>
                </td>
              </tr>
            </tbody></table>
          </td>
        </tr>
        <!--  END FOOTER COPY RIGHT -->


        </tbody></table>
        <!-- end 100 wrapper (white background) -->



        </body></html>
        """.format(name='Yi Chun')
    
    text = "Hola, tu nueva clave es: " + clave + "\n por favor ingresa aqui para reestablecer tu clave : " + url_local + "/auth/nuevaclave/" + userid

    # # Record the MIME types of both parts - text/plain and text/html.
    # part1 = MIMEText(text, 'plain')
    # part2 = MIMEText(html, 'html')

    # # Attach parts into message container.
    # # According to RFC 2046, the last part of a multipart message, in this case
    # # the HTML message, is best and preferred.
    # msg.attach(part1)
    # msg.attach(part2)  
      
    # # The actual mail send  
    # server = smtplib.SMTP('smtp.gmail.com:587')  
    # server.starttls()  
    # server.login(username, password)  
    # server.sendmail(fromaddr, toaddrs, msg.as_string())  
    # server.quit()

    message = sendgrid.Mail()
    message.set_from("{nombre} <{mail}>".format(nombre="Giani Da Firenze",mail="notification@tellmecuando.com"))
    message.add_to(["jose@loadingplay.com","yi@loadingplay.com"])
    message.set_subject("Reset contraseña")
    message.set_html(html)
    

    status, msg = sg.send(message)

    json_obj = json.loads(msg)

    if json_obj["message"] == "success":
        print "se envio exitosamente"
    else:
        print json_obj["errors"]
