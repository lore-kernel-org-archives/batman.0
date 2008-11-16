Message-ID: <5635aa0d0811160830r5521a8a4he0d5b22665664d7@mail.gmail.com>
Date: Sun, 16 Nov 2008 23:30:06 +0700
From: "Outback Dingo" <outbackdingo@gmail.com>
Subject: Re: [B.A.T.M.A.N.] batman-adv debian announcement
In-Reply-To: <200811170026.10020.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_23429_28850972.1226853006619"
References: <200811170004.23285.lindner_marek@yahoo.de>
	<5635aa0d0811160806h69169967w846a18250d77b87c@mail.gmail.com>
	<200811170026.10020.lindner_marek@yahoo.de>
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

------=_Part_23429_28850972.1226853006619
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

ok lastly, it seems possible its very similiar config to bmxd which is what
has been running, though layer 3, im trying to get layer 2 kernel routing
going
originally i used batgat but yet it was problematic, so its safe to say i
could go batman-adv and drop bmxd? as i belive one is not compatible with
the
other in the mesh

On Sun, Nov 16, 2008 at 11:26 PM, Marek Lindner <lindner_marek@yahoo.de>wrote:

> On Monday 17 November 2008 00:06:37 Outback Dingo wrote:
> > any good docs on configuring batman-adv for atheros ?
>
> We are writing it but it takes time.  :-)
>
>
> Here the short intro:
>
> Batman advanced is not aware of the Atheros driver. On every hardware it
> runs
> in the same way.
>
> Load the module -> modprobe batman-adv-core
>
> In /proc/net/batman-adv/ you will find the files to tweak batman. E.g. give
> it a
> device to operate on -> echo eth0 > /proc/net/batman-adv/interface
>
> deactivate batman-adv -> echo "" > /proc/net/batman-adv/interface
>
> The other files in that folder should be self explanatory. If not come back
> and
> ask us.
>
> Regards,
> Marek
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>

------=_Part_23429_28850972.1226853006619
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

ok lastly, it seems possible its very similiar config to bmxd which is what has been running, though layer 3, im trying to get layer 2 kernel routing going<br>originally i used batgat but yet it was problematic, so its safe to say i could go batman-adv and drop bmxd? as i belive one is not compatible with the <br>
other in the mesh <br><br><div class="gmail_quote">On Sun, Nov 16, 2008 at 11:26 PM, Marek Lindner <span dir="ltr">&lt;<a href="mailto:lindner_marek@yahoo.de">lindner_marek@yahoo.de</a>&gt;</span> wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">On Monday 17 November 2008 00:06:37 Outback Dingo wrote:<br>
&gt; any good docs on configuring batman-adv for atheros ?<br>
<br>
</div>We are writing it but it takes time. &nbsp;:-)<br>
<br>
<br>
Here the short intro:<br>
<br>
Batman advanced is not aware of the Atheros driver. On every hardware it runs<br>
in the same way.<br>
<br>
Load the module -&gt; modprobe batman-adv-core<br>
<br>
In /proc/net/batman-adv/ you will find the files to tweak batman. E.g. give it a<br>
device to operate on -&gt; echo eth0 &gt; /proc/net/batman-adv/interface<br>
<br>
deactivate batman-adv -&gt; echo &quot;&quot; &gt; /proc/net/batman-adv/interface<br>
<br>
The other files in that folder should be self explanatory. If not come back and<br>
ask us.<br>
<br>
Regards,<br>
<font color="#888888">Marek<br>
</font><div><div></div><div class="Wj3C7c"><br>
_______________________________________________<br>
B.A.T.M.A.N mailing list<br>
<a href="mailto:B.A.T.M.A.N@open-mesh.net">B.A.T.M.A.N@open-mesh.net</a><br>
<a href="https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n" target="_blank">https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n</a><br>
</div></div></blockquote></div><br>

------=_Part_23429_28850972.1226853006619--
