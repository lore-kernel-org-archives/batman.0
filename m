Return-Path: <ordex@autistici.org>
Date: Fri, 16 Aug 2013 08:30:40 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130816063040.GX849@ritirata.org>
References: <1376376232-2178-1-git-send-email-ordex@autistici.org>
 <1376376232-2178-4-git-send-email-ordex@autistici.org>
 <201308161205.49424.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="e4Ac2VUIqaLF2Uxx"
Content-Disposition: inline
In-Reply-To: <201308161205.49424.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 3/9] batman-adv: add bat_orig_print
 function API
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--e4Ac2VUIqaLF2Uxx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2013 at 12:05:49PM +0800, Marek Lindner wrote:
> On Tuesday, August 13, 2013 14:43:46 Antonio Quartulli wrote:
> > @@ -991,6 +991,7 @@ struct batadv_forw_packet {
> >   * @bat_primary_iface_set: called when primary interface is selected /
> > changed * @bat_ogm_schedule: prepare a new outgoing OGM for the send qu=
eue
> > * @bat_ogm_emit: send scheduled OGM
> > + * @bat_orig_print: print the originator table
> >   */
> >  struct batadv_algo_ops {
> >         struct hlist_node list;
> > @@ -1001,6 +1002,8 @@ struct batadv_algo_ops {
> >         void (*bat_primary_iface_set)(struct batadv_hard_iface
> > *hard_iface); void (*bat_ogm_schedule)(struct batadv_hard_iface
> > *hard_iface); void (*bat_ogm_emit)(struct batadv_forw_packet
> > *forw_packet); +       /* orig_node handling API */
> > +       void (*bat_orig_print)(struct batadv_priv *priv, struct seq_file
> > *seq); };
>=20
> How about adding the info somewhere that this callback is optional ?

Ok, will do it in the kernel doc.


>=20
> Cheers,
> Marek

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--e4Ac2VUIqaLF2Uxx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSDccQAAoJEADl0hg6qKeOiC8QAJJQ4nM5trNXGwmyqHcZDzh/
LlmDTmuEyG9QPH9vEzS6o00svEDFPazv5bGtni10iyq62cjvYAcrLr5YSjS1K/TX
Dj8ZdzhPG0o88pUpTvxbRdcreGZZkVioBKKI2fsV6B3jj6BRbCBX3Wwr/S0sbQ6v
34NoTnJSZE3Vw8fQepOuphUs9P1s7qYA/uFvoOEmuJJmBOn45mGvOt9qTGFOEfbG
mtWs314lueCP1wEeCwEOJeqS6JCuml8vh2MtA2tPQnzoaW6filFVTZ1jRvIF7Ao3
oR2fzj7Araf2oBGtQ99zieh6ucVDHdN3sJjI1EIg2kj+vVCZx7aPJ5wLDqP/F4Hx
YnZrGr/vw0R9vE3OIDW4+cbTDupO7gcNs6FgF+R8/95LhgO8ekYu45rsaFhbplhW
n/AAgt6iXSdxOxOKa6bgrOTFAHjwiJuni1NdaM0ALlvEDhOHieeE0jmoVRYCkKfQ
JB/JR4HD9P321FqIJrnoN9afZX0hvBV/haUOEE4gwmSGxwOLsbOxLOs/PUTk8xRh
sghK/ryxi0kaVcnnXnOSzcHlSnDTU5GFNCpxjpjwLwQ4LblHpcHbRR/eMFtMAkqQ
FEbZPMw5TzfRv4pit65bfqRCrDN03nZ39OCXd/b9a9uLrE4ljRjAQeaj8AbJXBUq
OSIdwLWlGAxtQpH9nvcs
=TuUl
-----END PGP SIGNATURE-----

--e4Ac2VUIqaLF2Uxx--
