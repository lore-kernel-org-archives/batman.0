Message-ID: <5635aa0d0809102122s4f528693o3aeb1795ce640d4e@mail.gmail.com>
Date: Thu, 11 Sep 2008 11:22:42 +0700
From: "Outback Dingo" <outbackdingo@gmail.com>
Subject: Re: [B.A.T.M.A.N.] BATGAT
In-Reply-To: <200809111101.31420.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_38075_29844564.1221106962745"
References: <8c906fa50809100941y79bc2011nd234780ad7b5cd0@mail.gmail.com>
	<20080910193801.GA10777@pandem0nium>
	<8c906fa50809101400i4c30cff5geb16998e11d7c607@mail.gmail.com>
	<200809111101.31420.lindner_marek@yahoo.de>
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

------=_Part_38075_29844564.1221106962745
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

http://pastebin.com/m1677070a

batgat crashed out, and unloaded without batgat batman routes never stay

using openwrt trunk, so whats the best solution

On Thu, Sep 11, 2008 at 10:01 AM, Marek Lindner <lindner_marek@yahoo.de>wrote:

> On Thursday, 11. September 2008 05:00:59 Gustavo Lindberg wrote:
> > I am experimenting very frustrating issues with batgat. Currently i am
> > testing the last trunk of kamikaze on ubiquity NS2. Batmand dies quietly
> > with batgat loaded. I will prove the last kamikaze on two NS2 without
> > batgat and inform the bug  if this error happen again.
>
> I think it would be intersting to find out why batmand dies. May be you
> could
> produce a core dump ?
> Indeed, we have a problem if the batman daemon dies without telling the
> module. What about adding a keep alive + timeout in the module ?
>
> Greetings,
> Marek
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>

------=_Part_38075_29844564.1221106962745
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr"><a href="http://pastebin.com/m1677070a" target="_blank">http://pastebin.com/m1677070a</a><br><br>batgat crashed out, and unloaded without batgat batman routes never stay <br><br>using openwrt trunk, so whats the best solution<br>
<br><div class="gmail_quote">On Thu, Sep 11, 2008 at 10:01 AM, Marek Lindner <span dir="ltr">&lt;<a href="mailto:lindner_marek@yahoo.de">lindner_marek@yahoo.de</a>&gt;</span> wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">On Thursday, 11. September 2008 05:00:59 Gustavo Lindberg wrote:<br>
&gt; I am experimenting very frustrating issues with batgat. Currently i am<br>
&gt; testing the last trunk of kamikaze on ubiquity NS2. Batmand dies quietly<br>
&gt; with batgat loaded. I will prove the last kamikaze on two NS2 without<br>
&gt; batgat and inform the bug &nbsp;if this error happen again.<br>
<br>
</div>I think it would be intersting to find out why batmand dies. May be you could<br>
produce a core dump ?<br>
Indeed, we have a problem if the batman daemon dies without telling the<br>
module. What about adding a keep alive + timeout in the module ?<br>
<br>
Greetings,<br>
<font color="#888888">Marek<br>
</font><div><div></div><div class="Wj3C7c">_______________________________________________<br>
B.A.T.M.A.N mailing list<br>
<a href="mailto:B.A.T.M.A.N@open-mesh.net">B.A.T.M.A.N@open-mesh.net</a><br>
<a href="https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n" target="_blank">https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n</a><br>
</div></div></blockquote></div><br></div>

------=_Part_38075_29844564.1221106962745--
