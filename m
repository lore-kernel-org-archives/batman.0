Message-ID: <c1004cd20806160912q72e6b258o27d5a98d0597ba4f@mail.gmail.com>
Date: Mon, 16 Jun 2008 18:12:34 +0200
From: "thomas anderson" <eidos85@gmail.com>
Subject: Re: [B.A.T.M.A.N.] Error " LibG3D-WARNING **: no handler for file "
	with meshs3d
In-Reply-To: <200806161508.27511.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_6791_3864582.1213632754795"
References: <e58370e60806160527y7536a733la99c827ba944211f@mail.gmail.com>
	<200806161508.27511.sven.eckelmann@gmx.de>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

------=_Part_6791_3864582.1213632754795
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Now it works i just installed the libg3d-plugins on a Ubuntu box.
Thank you!
Eidos

2008/6/16 Sven Eckelmann <sven.eckelmann@gmx.de>:

> You wrote:
> > I
> > received the same error just when I'm not root or when another meshs3d
> > process is running, but ever the symbols are appeared.
> Can you rewrite this sentence? I am not able to understand when something
> (not?) happens.
>
> > ldd of meshs3d recognize libg3d library. What do you exactly mean with
> > those 3ds plugins? where can we found them or realize if we've got them
> > installed?
> libg3d has its own plugin infrastructure and you cannot detect dependencies
> with running ldd on meshs3d. If you have installed the debian package for
> libg3d then you should have another one with the name libg3d-plugins which
> also must be installed. (Yes, the package description is wrong and the next
> debian package release should have it marked as recommended for libg3d).
> To check if you have the plugin installed, search for imp_3ds.so in /usr
> (if
> you have installed libg3d there).
>
> find /usr/lib -name "imp_3ds.so"
>
> Please check file permissions if find is successful.
>
> Best Regards,
>         Sven
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>
>

------=_Part_6791_3864582.1213632754795
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Now it works i just installed the libg3d-plugins on a Ubuntu box.<br>Thank you!<br>Eidos<br><br><div class="gmail_quote">2008/6/16 Sven Eckelmann &lt;<a href="mailto:sven.eckelmann@gmx.de">sven.eckelmann@gmx.de</a>&gt;:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class="Ih2E3d">You wrote:<br>
&gt; I<br>
&gt; received the same error just when I&#39;m not root or when another meshs3d<br>
&gt; process is running, but ever the symbols are appeared.<br>
</div>Can you rewrite this sentence? I am not able to understand when something<br>
(not?) happens.<br>
<div class="Ih2E3d"><br>
&gt; ldd of meshs3d recognize libg3d library. What do you exactly mean with<br>
&gt; those 3ds plugins? where can we found them or realize if we&#39;ve got them<br>
&gt; installed?<br>
</div>libg3d has its own plugin infrastructure and you cannot detect dependencies<br>
with running ldd on meshs3d. If you have installed the debian package for<br>
libg3d then you should have another one with the name libg3d-plugins which<br>
also must be installed. (Yes, the package description is wrong and the next<br>
debian package release should have it marked as recommended for libg3d).<br>
To check if you have the plugin installed, search for imp_3ds.so in /usr (if<br>
you have installed libg3d there).<br>
<br>
find /usr/lib -name &quot;imp_3ds.so&quot;<br>
<br>
Please check file permissions if find is successful.<br>
<br>
Best Regards,<br>
<font color="#888888"> &nbsp; &nbsp; &nbsp; &nbsp;Sven<br>
</font><br>_______________________________________________<br>
B.A.T.M.A.N mailing list<br>
<a href="mailto:B.A.T.M.A.N@open-mesh.net">B.A.T.M.A.N@open-mesh.net</a><br>
<a href="https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n" target="_blank">https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n</a><br>
<br></blockquote></div><br>

------=_Part_6791_3864582.1213632754795--
