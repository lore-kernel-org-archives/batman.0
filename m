Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 10 Feb 2016 18:45:43 +0800
Message-ID: <1741015.0MXJ0zPZBk@voltaire>
In-Reply-To: <1454243280-15126-2-git-send-email-sven@narfation.org>
References: <1454243280-15126-1-git-send-email-sven@narfation.org>
 <1454243280-15126-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart90952573.xKVNDkrYo8";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maint 2/2] batman-adv: Only put
	orig_node_vlan list reference when removed
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

--nextPart90952573.xKVNDkrYo8
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, January 31, 2016 13:28:00 Sven Eckelmann wrote:
> The batadv_orig_node_vlan reference counter in batadv_tt_global_size_mod
> can only be reduced when the list entry was actually removed. Otherwise the
> reference counter may reach zero when batadv_tt_global_size_mod is called
> from two different contexts for the same orig_node_vlan but only one
> context is actually removing the entry from the list.
> 
> The release function for this orig_node_vlan is not called inside the
> vlan_list_lock spinlock protected region because the function
> batadv_tt_global_size_mod still holds a orig_node_vlan reference for the
> object pointer on the stack. Thus the actual release function (when
> required) will be called only at the end of the function.
> 
> Fixes: 21a57f6e7a3b ("batman-adv: make the TT CRC logic VLAN specific")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/translation-table.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Applied in revision ead9389.

Thanks,
Marek

--nextPart90952573.xKVNDkrYo8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWuxTXAAoJEFNVTo/uthzANboH/1isjv1SKkC1UKXIY7sz/BIt
FzuRjvWMngeDwkcsC1jJKjgSoldZH80QajNeazfi43voqzSYpmmxtq6HIsmkh4P6
A/j9nU7CknDLxFKjUuU+2ZiJ9eS3rN4BCmGzww0jZUhBPH+TaQTgSIA4qzn8zEeQ
Ehb7vsOrMn+MXAibYaAZyd+CMIYyC167uEJm9+lU+eULyPnmtJYrEWB6X9hUwAWh
JsA402zYhSTlme/GWsYLGYk0jO60pFE7BvqE3/rlMh23xajgpiIQ77k1dNveGr59
T+YZDv1KkolJ/xWwh1nJyjCYsRTewuFUqT4RCaofNKkcvy8l0SqBARVImsFUqEA=
=2i7c
-----END PGP SIGNATURE-----

--nextPart90952573.xKVNDkrYo8--

