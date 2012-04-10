Return-Path: <ordex@autistici.org>
Date: Tue, 10 Apr 2012 20:17:03 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120410181702.GB23540@ritirata.org>
References: <1333543332-26942-1-git-send-email-ordex@autistici.org>
	<1333543332-26942-4-git-send-email-ordex@autistici.org>
	<4F83146E.2080609@hundeboll.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Content-Disposition: inline
In-Reply-To: <4F83146E.2080609@hundeboll.net>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 3/4] batman-adv: let
 tt_global_entry_has_orig() return the orig_entry or NULL instead of 1 or 0
 only
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On Mon, Apr 09, 2012 at 06:55:10PM +0200, Martin Hundeb=C3=B8ll wrote:
> Hi Antonio,
>=20
> On 04/04/2012 02:42 PM, Antonio Quartulli wrote:
>=20
> >   	rcu_read_lock();
> >   	head =3D&entry->orig_list;
> >   	hlist_for_each_entry_rcu(tmp_orig_entry, node, head, list) {
> >   		if (tmp_orig_entry->orig_node =3D=3D orig_node) {
> > -			found =3D true;
> > +			orig_entry =3D tmp_orig_entry;
> >   			break;
> >   		}
> >   	}
> >   	rcu_read_unlock();
> > -	return found;
> > +	return orig_entry;
> >   }
>=20
> I'm not that well into the tt code, but shouldn't there be some reference=
 counting when handing pointers round like this?
>=20

mh..I'd agree with you. The entry could be freed somewhere else causing
something we would never imagine ;P

Actually the tt_orig_list_entry doesn't have any mechanism like that and so=
 I
forgot about taking care of this issue.

Thank you very much!

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJPhHkeAAoJEFMQTLzJFOZFMYwIAJYuDUqNrqOJ97ZjBn9Wir4W
U9SEz1KxyPA1K24Bw79fHCscI6f/gaxhNDDY+UBplRCv9bzKwlJgvdel/QeTHcZJ
Oo4hNuBo5li+1XJOZdOl5vDkM3XKAdJn5X1o3MU5fwT/LwJ6Y5FAb8FMowikM6o4
LTOagOPGBKLZdO/zsWBSygaljlvAWoIeuTg43ro7rmLtsi164RghcZPcwpKJTSzt
yMwHpigB2yID5USxAX8APpgq4Rfd79puH5ik6rqc3OUJDiE76B19C24CccY2S7FI
1xfnp8mz7WYIoKA7ieO30TanChEb2ICFMeEX3No87iqK04whynwEqjlD0rw1P+s=
=Qdtw
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--
