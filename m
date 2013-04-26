Return-Path: <ordex@autistici.org>
Date: Fri, 26 Apr 2013 22:54:25 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130426205425.GL16603@ritirata.org>
References: <517AD5DB.1040600@wirelesspt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jITzwD3HDGXid3BE"
Content-Disposition: inline
In-Reply-To: <517AD5DB.1040600@wirelesspt.net>
Subject: Re: [B.A.T.M.A.N.] Batman-adv and Uevent (gateway/client modes)
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: cmsv@wirelesspt.net, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--jITzwD3HDGXid3BE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2013 at 03:30:35PM -0400, cmsv wrote:
> I have reached a point where i need to start using the uevent
> functionality to work around some network scenarios when the gateways
> lose internet access but i am having a bit of a difficult time
> understanding how to do it since making use of uevents which is
> something new to me.
>=20
> The explanation here is not helping much either
> http://www.open-mesh.org/projects/batman-adv/wiki/Uevent
>=20
> and i understand that i might need to go to the basics to understand it
> and learn how to code.
>=20
> My need to use uevents to change a nodes behaviour is to change a node
> from server to client and vice versa when it loses connectivity to the
> WAN (not for example losing connectivity to the dsl router that is
> actually the gateway but that has the node as a LAN client)

The uevents in batman-adv (as explained in the wiki) are "messages" sent by
the kernel module when a particular event (internal to batman-adv) occurs.

WAN on/off is an event which comes from an external source and so you do not
need to bother the batman-adv's uevents.

>=20
> I am assuming that uevents will allow me to work with this physical
> setup correct?
>=20

Not uevents from batman-adv. If something else can trigger a uevent for you=
 then
yes. But you will not get any help from the uevents in batman-adv in this c=
ase.


> As far as i understand now and if i am not mistaken when a gateway loses
> WAN connectivity the node that is making use of uevents will change  the
> node from "server" to "client" on batman-adv .
>=20

This is a mechanism that you have to implement in your firmware. batman-adv
alone cannot do that because it does not know when the connection goes down.

I can say that this is probably a behaviour that you may want, but batman-a=
dv
won't help you in this.

> Now my question is if i can also make it to change the dhcp setup from
> dhcp server to inactive and receive it=C2=B4s dhcp service from another
> gateway node.
>=20
> In theory  something like this would be executed on openwrt when a
> gateway node detects no connectivity to the wan:
>=20
> uci set batman-adv.bat0.gw_mode=3Dclient ;
> uci commit batman-adv ;
> batman-adv reboot ;
> uci set dhcp.lan.force=3D0 ;
> uci set dhcp.lan.ignore=3D1 ;
> uci commit dhcp ;
> /etc/init.d/dnsmasq restart ;
>=20
> when it detects wan connectivity it will want to become a server and
> will auto execute:
>=20
> uci set batman-adv.bat0.gw_mode=3Dserver ;
> uci commit batman-adv ;
> batman-adv reboot ;
> uci set dhcp.lan.force=3D1 ;
> uci set dhcp.lan.ignore=3D0 ;
> uci commit dhcp ;
> /etc/init.d/dnsmasq restart ;
>=20
> A small script can even be made in order so simplify things either
> automatically or manually and lets call it:
> gateway-mode
> client-mode
>=20
> Upon detecting no WAN connectivity the script will be activated.
>=20
> Am i on the right track so far (at least in theory) ?
>=20

Maybe. All this stuff I guess have to be applied on an OpenWRT system, but I
don't know it enough to answer. Maybe on the Openwrt channel/list somebody =
will
be able to help you in this direction.

> Now the second part is how to detect WAN connectivity which is different
> from noticing that there is no connectivity to the actual gw router that
> has the node on it's LAN.
>=20
> I thought about a ping test to a few address from which after 100% loss
> reply from all; something or Uevent will activate the gateway/client
> mode script but it creates another problem ahead.
>=20
> In a quick conversation with ordex on irc i understand that i have to
> invoke the wiki docs uevent functions with the parameters i want at the
> moment i decide.

This is an internal function that can be used by a developer to "add new ue=
vents
to batman-adv". Here you want to play with something totally external and
totally unrelated to batman-adv. So the uevents wikipage can't help you :)


> This can be the gateway/client mode script
>=20
> correct ?
>=20
> Since uevent is something new to me; can someone recommend some freshman
> tutorial that may take me in the right direction. I have no clue where
> or how to start looking to code it and also when coded; where will it be
> added.
>=20
> I also would like to ask anyone that has uevent working how they are
> using it for the same type of need and maybe even share some recipe.
>=20
>=20
>=20


Sometimes I used ifplugd to detect whether an Ethernet link was UP or not..=
you
may want to look into it as well.

Cheers,



--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--jITzwD3HDGXid3BE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJReumAAAoJEADl0hg6qKeORtgP/1DrnTDi7woDbDfrN7atgyrp
CPIJLqznIEbX3mNLlNsva2XM4VFd7HEeGTqR3LIJqyII6fyxRrSsUboM9xgSiADX
wm30LRLDq9xvkFd8MdLgD+Fb5JwQwIoGPu+TISDUmTukqj0oJedt6IeY20120w5i
PPLZHAu4/hHXQISR3nmiUuJvE1S5chcKVijMO9jrMthleaYFrogE0mOMF/NAcA3O
FznkUw1MHlp7h9KYGYPK4R0wdrJNsvU5tEE/vSnZ8XwRm7K1CK7CWFSjaKaB2UH+
whfXRSIr308T9arAXdqg7/YqJSqP4ttOjfhq1OmiTXWxbZe5KOKmUFyzdpmg3wrb
hyRlE35UcmWJCVQYiUWX3ZtjNBnSyuA4FQ13mV/MmyP1vE/cZRCRsnGhx1vTUmwl
dwkS+DFpJvlhy/cr4K3nas5H1Jcn6QH3tSZMCXm0h2dxC7w74Nb0ZABjBP4j537r
AbjN6KXhdnwrBrbg3OoNTJ305ahHbZs3wTJdAN3MoU9vwM4ymeqStHKEGruLflmy
Sp/Mu7faKmzq3m6PxvJaSk4Qefm12uZOwD1ZXJ4wm0yjEa+O0GeBLqmqzZznlSDT
Jlosci7MgzPRVECsnghzBNMi6//8yUxaDCoqGU8+M3193izjFiCeEimhYeuE4mff
rTLYamdUWzpeSyJFe/PJ
=hx8J
-----END PGP SIGNATURE-----

--jITzwD3HDGXid3BE--
