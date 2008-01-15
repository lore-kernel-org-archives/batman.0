Message-ID: <BLU134-W3993EA83B0AA37D57C1E69E1470@phx.gbl>
From: Carlo Beccia <carlo.beccia@hotmail.it>
Subject: RE: [B.A.T.M.A.N.] Basic question
Date: Tue, 15 Jan 2008 14:41:19 +0000
In-Reply-To: <20080115142536.GA7314@hrz.tu-chemnitz.de>
References: <BLU134-W199EC580346187E750B911E1470@phx.gbl>
	<200801151243.27415.lindner_marek@yahoo.de>
	<BLU134-W258B642D8C3F7F4093850E1470@phx.gbl> 
	<20080115142536.GA7314@hrz.tu-chemnitz.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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




Hi Simon,
thank you very much...much easier then I tought....probably I was wrong bec=
ause of the madwifi directories into the svn repository....
Ok tonight I will try....

Thank you very much again...

Regards, Carlo

----------------------------------------
> Date: Tue, 15 Jan 2008 15:25:36 +0100
> From: simon.wunderlich@s2003.tu-chemnitz.de
> To: b.a.t.m.a.n@open-mesh.net
> Subject: Re: [B.A.T.M.A.N.] Basic question
>=20
> Hello Carlo,
>=20
> batman-adv-kernelland is currently not integrated in madwifi (this is
> just another idea on our TODO list). You only need to compile the
> batman-adv-kernelland/batman-core/ directory against your kernel.
> This gives you the batman-adv-core.ko module which you can insmod and is
> independent from madwifi (and any other driver).
>=20
> Best Regards,
> 	Simon
>=20
> On Tue, Jan 15, 2008 at 12:59:00PM +0000, Carlo Beccia wrote:
> >=20
> >=20
> >=20
> > Hi Marek,
> > thank you for your quick reply....
> >=20
> > I would like to compile the module...I don't need the complete openwrt =
integration...
> > I would like to see and study your (you all) work on kernel space.....
> >=20
> > At the moment I have already build a custom openwrt firmware....but fro=
m what I understand I need to patch the madwifi driver to support the new f=
eature and recompile the driver....then I can build the batman module...
> > I need only some hint on what steps to take in order to compile the mod=
ule...I doesn't seem so difficult but i wanna follow the right steps...
> >=20
> > Obviously if I don't waste your time.....
> >=20
> > Regards, Carlo
> >=20
> > ----------------------------------------
> > > From: lindner_marek@yahoo.de
> > > To: b.a.t.m.a.n@open-mesh.net
> > > Subject: Re: [B.A.T.M.A.N.] Basic question
> > > Date: Tue, 15 Jan 2008 12:43:27 +0100
> > >=20
> > >=20
> > > Hi,
> > >=20
> > > > How can I compile the stuff
> > > > https://dev.open-mesh.net/svn/batman/trunk/batman-adv-kernelland/ i=
nto
> > > > openwrt...I would like to try the layer 2 version on my fonera rout=
er....
> > >=20
> > > currently I'm working on the batman openwrt integration. It is a bit =
tricky=20
> > > and I'm not 100% finished yet. It will be included in the latest kami=
kaze=20
> > > trunk. Either you wait some more days or I send you my current status.
> > >=20
> > >=20
> > > > I don't understand if I have to integrate it in a package inside the
> > > > menuconfig or I can build everything off from the standard configur=
ation...
> > >=20
> > > You can't use the standard configuration.
> > >=20
> > > Greetings,
> > > Marek
> > > _______________________________________________
> > > B.A.T.M.A.N mailing list
> > > B.A.T.M.A.N@open-mesh.net
> > > https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
> >=20
> > _________________________________________________________________
> > Ti piace giocare con le lettere? Prova ABCLive!
> > http://messengergiochi.it.msn.com/
> > _______________________________________________
> > B.A.T.M.A.N mailing list
> > B.A.T.M.A.N@open-mesh.net
> > https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n

_________________________________________________________________
Conosci Doretta? Contattala, =E8 ora su Messenger!
http://www.doretta82.it/banner/index.html
