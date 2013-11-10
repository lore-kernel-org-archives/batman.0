Return-Path: <antonio@meshcoding.com>
Date: Sun, 10 Nov 2013 20:18:53 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <20131110191853.GP970@neomailbox.net>
References: <1384061349-17901-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YzytRCpZNWCht94M"
Content-Disposition: inline
In-Reply-To: <1384061349-17901-1-git-send-email-linus.luessing@web.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: introduce capability
 initialization bitfield
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


--YzytRCpZNWCht94M
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 10, 2013 at 06:29:09AM +0100, Linus L=C3=BCssing wrote:
> @@ -251,10 +251,12 @@ struct batadv_orig_node {
>   * enum batadv_orig_capabilities - orig node capabilities
>   * @BATADV_ORIG_CAPA_HAS_DAT: orig node has distributed arp table enabled
>   * @BATADV_ORIG_CAPA_HAS_NC: orig node has network coding enabled
> + * @BATADV_ORIG_CAPA_HAS_TVLV: orig node has tvlv capability
>   */
>  enum batadv_orig_capabilities {
>  	BATADV_ORIG_CAPA_HAS_DAT =3D BIT(0),
>  	BATADV_ORIG_CAPA_HAS_NC =3D BIT(1),
> +	BATADV_ORIG_CAPA_HAS_TVLV =3D BIT(2),


Hi Linus,

why did you name the flag BATADV_ORIG_CAPA_HAS_TVLV instead of
BATADV_ORIG_CAPA_HAS_TT ?

Am I missing something or you picked up the wrong name? :)


Cheers,


--=20
Antonio Quartulli

--YzytRCpZNWCht94M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJSf9wdAAoJEADl0hg6qKeO2WkP/RZ2W0jvhVV3gy3eLbihs7UN
bZWOX8bPbAG/xPM4kfgL74AtMkKu+ey2k0C+2ke4V1OAZkZd8pwhY9Z+QfjAOeg4
/YYG0m6BAkWfjE4IhMtlU7nK1Q2J6aT72/mAyUOkPAIzDyolXMJbBTx29wCJflBZ
FO4+ebpzaj5l2Sj8hbVBiU8m+/IQ1cqD2FfCieMNRuX7BNYm1WYT7h6yPCkgCsqc
WxQ2vxWuIszCcIsQvuGXx1EafIaOTu7xNlynDj8vgkqpSMGMToUJwFnGiC4jZDjN
bSxIz87j3WpWw+FQ6YKkKFhNk1ci1O9OA/RmfXVROUQGbihMh+ytBEGpvnqS2R6w
UdVRBhTyvBmw1LCvu0iPbmlIw1xTdK0zo8V9ZkosO+anm73SiSVuZo68zoCIuLEH
PZ5NB13E/DjjXrzRF4BrOnAl6JvTSwNGa1xEeAV2qPEoYpusbljAouxMJjjXaNKp
XGDsWzT7wiJdtTbX/RqGpJCtVteOEbwdwOQXd9HDnRHZVJnYwgOScJi2HMPRTZzF
rBoh/SmWcYwbYh7ZWuwZ4wy2NbGimZeFfnCMEXHwjdp3xCvi6XmWJECDs+1LH/oE
ppO3sDf1rKPCQsCP2r3MZGTtxTYSv7NOO19XSMoQJs6dImSdhXhkcGmwi1tzsJiQ
UC7JSXV3vEqUcizsfz1C
=SSiA
-----END PGP SIGNATURE-----

--YzytRCpZNWCht94M--
