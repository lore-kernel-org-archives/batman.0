Return-Path: <a@unstable.cc>
Date: Fri, 20 May 2016 20:56:26 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160520125626.GU12056@prodigo.lan>
References: <1462525107-19750-1-git-send-email-apape@phoenixcontact.com>
 <1462525107-19750-3-git-send-email-apape@phoenixcontact.com>
 <20160519194553.GD12565@otheros>
 <OF496B57CC.AA9E34DD-ONC1257FB9.003EB7CF-C1257FB9.003F68A4@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YZa61AII3s1sGKYx"
Content-Disposition: inline
In-Reply-To: <OF496B57CC.AA9E34DD-ONC1257FB9.003EB7CF-C1257FB9.003F68A4@phoenixcontact.com>
Subject: Re: [B.A.T.M.A.N.] Antwort: Re: [PATCHv3 2/6] batman-adv: speed up
 dat by snooping received ip traffic
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--YZa61AII3s1sGKYx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 20, 2016 at 01:32:35PM +0200, Andreas Pape wrote:
> "B.A.T.M.A.N" <b.a.t.m.a.n-bounces@lists.open-mesh.org> schrieb am
> 19.05.2016 21:45:53:
>=20
> > Von: Linus L=FCssing <linus.luessing@c0d3.blue>
> > An: The list for a Better Approach To Mobile Ad-hoc Networking
> > <b.a.t.m.a.n@lists.open-mesh.org>
> > Datum: 19.05.2016 21:47
> > Betreff: Re: [B.A.T.M.A.N.] [PATCHv3 2/6] batman-adv: speed up dat
> > by snooping received ip traffic
> > Gesendet von: "B.A.T.M.A.N" <b.a.t.m.a.n-bounces@lists.open-mesh.org>
> >
> > On Fri, May 06, 2016 at 10:58:23AM +0200, Andreas Pape wrote:
> > > +void batadv_dat_entry_check(struct batadv_priv *bat_priv, struct
> > sk_buff *skb,
> > > +             unsigned short vid)
> > > +{
> > [...]
> > > +   if (iphdr) {
> > > +      batadv_dbg(BATADV_DBG_DAT, bat_priv,
> > > +            "Snooped IP address: %pI4 %pM (vid: %d)\n",
> > > +            &iphdr->saddr, ethhdr->h_source,
> > > +            BATADV_PRINT_VID(vid));
> > > +      batadv_dat_entry_add(bat_priv, iphdr->saddr,
> > > +                 ethhdr->h_source, vid);
> > > +   }
> >
> > Not sure whether it is necessary, or whether there is a check
> > somewhere later within DAT. But should we exclude some
> > iphdr->saddr or ethhdr->h_source addresses? For instance a
> > DHCPDISCOVER usually has a zero-ip address.
>=20
> I think you have a good point here. Excluding especially
> ip addresses like zero-ip address seems reasonable. Although
> I think that this isn't a problem as long as no one is sending
> arp requests for such ip addresses, filling the dat table with
> unreasonable entries isn't a smart idea either. I will add some
> additional tests here for reasonable ip addresses for the next
> version of the patchset.

We already have some checks in the snooping functions that are performed wh=
en
calling batadv_arp_get_type(). Aren't those enough ?

Cheers,


--=20
Antonio Quartulli

--YZa61AII3s1sGKYx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXPwl6AAoJEJ4aZjxxc6bKyC4P/1o+VcKiApUKUwbyZevfK8mT
rluIWuTieg0SX7f4BHvUAocU6bv5qHgoQmXbyfYitojbDz4bPa4ENIenQ7YNDkin
b54unkZWupPjM4VzDoH2UehuV6WP79oJ663muQIAdlhOYPwCwb0ph0Ap2O6u2yXt
/WpaDJBFov4g6XY/D2NODnqF2UP2utGUnAkR5/ChhG9oaSJEGBlCQr93DlDCwjYW
T7txujORhwr2Z81uEB3QT2dvnC7Lgr0pG4/GhvFglJct3xz8boeZ99kJv1I7a8eg
Q/YHxGii/3LSduvg1p2O28fVntUYo3UB9F8C1FMA9o55mlK2xWIVuw5G6BrN806l
TUeNH9mgNGMMzoB65W3KpLLnsX0nldio6WcMrfZ0c8B/S1597ottXBVwQqD/qQCR
5BvAv1RoiQU9Q1nv4xTAlyLEPD9ejgq46YrL+IEXHY5JMSyW2iWvs1Rfsp+xeX3b
xiqqWn/1yzOgoXIUE0rnXSNRAoi+84BsSQm/pxM6s1G3Rz1uoGRB6xEu6UsWQYOh
NAa/JlSTTtObpEvRedenLtD9oFeg+ULxoUu1tOkpt6kGzRs43GoHYE6OkLlbDcOT
yHKbTw4p8dka3d15Fzj3OStnilsDWWRpmkHqypLh1jAxFFSCce6PPPGCekA6yATu
N2tbY0uteZm4ygJGJ4WS
=/Ny8
-----END PGP SIGNATURE-----

--YZa61AII3s1sGKYx--
