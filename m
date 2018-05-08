Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 08 May 2018 10:45:51 +0200
Message-ID: <2006071.d5ofkIttSZ@bentobox>
In-Reply-To: <7337501.sxbCbvYRv0@bentobox>
References: <20180506195559.32602-1-me@irrelefant.net>
 <b8f1dd55-d22a-0590-c27a-9c46344af809@irrelefant.net>
 <7337501.sxbCbvYRv0@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2046278.sEHFLXJWOo";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC PATCH] batman-adv: mitigate issue when
 empty vlan is received
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Leonardo =?ISO-8859-1?Q?M=F6rlein?= <me@irrelefant.net>, Antonio Quartulli <a@unstable.cc>

--nextPart2046278.sEHFLXJWOo
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

n Montag, 7. Mai 2018 12:23:57 CEST Sven Eckelmann wrote:
> This would sound to me like the vlan should just be=20
> created instead of adding this workaround. But maybe you should discuss t=
he=20
> details here with Antonio because at the end it is just about the differe=
nt=20
> ways of handling "!vlan" case from your patch.

Just had a look at the cleanup code for vlans and it seems like each vlan
in vlan_list must contain at least one entry (according to
vlan->tt.num_entries) and otherwise batadv_tt_global_size_mod will drop it.
So it isn't as easy as just adding a simple vlan for each received vlan
entry via TT response.

So your patch (or a variant of it) will most likely be the way to go for
receivers.


Now to your commit message:

On Sonntag, 6. Mai 2018 21:55:59 CEST Leonardo M=F6rlein wrote:

> batman-adv: mitigate issue when empty vlan is received

Something more specific would be nice. Maybe somebody else has a better
idea but what about:

batman-adv: Mitigate TT loop when receiving empty VLAN


> This patch is not a fix for the issue itself, but a fix for the
> other nodes, which are also influenced by the issue.

I personally don't like to read "this patch" in commit messages. This part
should maybe be reformulated and put at the end (before the Fixes line).
Something like:

While the problem is caused by the sender, the receiver can mitigate the
problem by ignoring (potentially) empty VLANs during the CRC check.

[...]
> - This behaviour is a bug! Batman-adv nodes must not send TT
>   announcements for empty vlans.

Where is this defined as incorrect message? But yes, the current
implementation cannot handle it.

> - The receiving batman-adv can not handle incoming TT announcements
>   with empty vlans. (The crc check routine batadv_tt_global_check_crc()
>   fails.)

This is to vague as discussed earlier. Maybe something more like:

=2D The receiving batman-adv can not handle incoming TT announcements with
  empty vlans. No new struct batadv_orig_node_vlan entry will be added
  to batadv_orig_node->vlan_list. This will cause the crc check routine
  batadv_tt_global_check_crc() to fail because it cannot find the local
  representation of this empty vlan.

[...]
> - This causes a lot of unneeded TT traffic. In Freifunk Hannover we
>   decreased the amount of from ~20kpp/s to ~4kpp/s on our supernodes.
>   We have ~800 nodes, which are connected via vpn to one of six
>   supernodes. Those supernodes are connected with each other in a fully
>   connected mesh.

This part doesn't seem to fit in the list and might just be a new paragraph
at the end to summarize the impact of the problem.


A "Fixes: " line is missing here. Please check whether this sounds about
right:

=46ixes: 7ea7b4a14275 ("batman-adv: make the TT CRC logic VLAN specific")


Kind regards,
	Sven


--nextPart2046278.sEHFLXJWOo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlrxY78ACgkQXYcKB8Em
e0bDOhAAmwD0z/py0/KRT/svH4KoHGGRLYJ2HsZ/4Yzq/RGA8I5ZQLGAot+h9sMv
ZInC3fafCYOZCe2gtIDP/vG20pwP85BP4CpTx4jg4TYrcDZ9vXdmFES2koUi/9NL
Keeb57EUEP8iCrv4+E6ExR+HhMM9UA4eu6bsx3jJfHPToQPQfhUTv3HztKVF7Yv+
GhrW+AZjyy4zJWKqJVzRJmTGYOcL6NZtiXSjZ8rRu6ShOnh+MkPPxQI1G+wBdObQ
s8kGgo5Yc1JnG2zL0/xTWUIeCKy86oBryUJCys1r6hEVTNFyQOJmFDbcfidt/SeV
3x6bSbNlD/RDnTmSH+qlXzov/BPc38TDIzjULoyS/Zb1olt7ruiaP2qHzLsCvFpU
Z8YEpmQDkXOi3NPl2F/TfCp9O1UxhIYFZaDrv4sIyP+LjjN7KU4kLHIsu86qCBB9
EuUrLm80ePNr3ZSlHIuUtTLljKHesBE1OvHgqoi7UHrwEkWyr80XOk3n/GbnVBkz
CTTOjkfFz/IRoGGp0UKb6iNikyUs/OTxMP72SFyZurVR9ZjnA7uBpSUmmh6/jIBS
QiG68a9nA9OD1rBnxE5kj6asE6EhJsojwYprWh0CQVnKnPpgqbrvoJJnCAtLzXLU
eHyU41aoBzsXH7tKp5FcvmoVVN4jbO4O7wR+cxpGdYo+dCXOpgA=
=GAi9
-----END PGP SIGNATURE-----

--nextPart2046278.sEHFLXJWOo--

