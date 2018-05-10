Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 10 May 2018 19:02:40 +0200
Message-ID: <44905128.CbDZRqSBqu@sven-edge>
In-Reply-To: <20180510152752.2557-1-mareklindner@neomailbox.ch>
References: <20180510152752.2557-1-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart381516546.hc3ZE7W9pX";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC maint] batman-adv: fix adding VLANs with
 partial state
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>, me@irrelefant.net

--nextPart381516546.hc3ZE7W9pX
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Donnerstag, 10. Mai 2018 17:27:52 CEST Marek Lindner wrote:
> Amongst other things, the MAC address of
> the VLAN interface itself has to be stored.
>
> Without this change a VLAN and its infrastructure could be created
> while the interface MAC address is not stored without triggering
> any error, thus creating issues in other parts of the code.

Actually, the call to batadv_tt_local_add is using the address from the softif 
and not from the vlan interface. Just some remark because it let me think 
about the way the "-1" no-VLAN is added.

I would really like to know what exactly failed here. Does Leonardo's system 
really try to add the VLAN 0 before it is storing the info for the no-vlan 
(-1/BATADV_NO_FLAGS) and the mac address is "invalid" for VLAN 0? Or maybe 
both failed and he is just lucky that he got some non-permanent entries for 
this device on the non-vlan "vlan" - I am not sure about that.

On Donnerstag, 10. Mai 2018 18:24:50 CEST Antonio Quartulli wrote:
> A failure of this function will cause a failure of the
> ndo_vlan_rx_add_vid() call made by the kernel/netlink API which in turns
> will reach the userspace.
> 
> Ideally any userspace application that attempted to create the VLAN
> should be in charge of re-attempting the creation again (I believe).
> 
> About your point 4, this should not be possible, because in case of
> error the bat0.X interface won't be created by the kernel at all. no?

Yes, this seems to be true for batadv_interface_add_vid. Still an open 
question for the batadv_hard_if_event (which cannot return an error to the 
caller). Would be interesting to know whether Leonardo's node fails for both 
calls or only for one (see above).

Kind regards,
	Sven
--nextPart381516546.hc3ZE7W9pX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlr0ezAACgkQXYcKB8Em
e0bPHw//XdI25MIWoavBEigjeYArftLEZWHFRnYoexso+5yjx8VkPrX0S2vdgSXA
N2u1ZhBgu6CrA9JQJJ6u/FJ3q0qdA2fs5eSPS9J78Qdb0VUSrC5A4VE/W7yI1D0x
dH0mnkTWctDaZkg0sVQ7QztR2AW4k17v7nNZYsOsPoh8uvSQE8gUo9JaTktUYnZT
8d7bFmZwmyopPbTjTkUxk5wwYhcqk8B8JvkwBbI6ARo2uXzsnLjK+DyZlptamF+J
HK+urchBoB+7WoaBpEUZgVxeYbDTpSDT8uBwRM5JomrLupixjUIIy/kxGdHSO9cG
a42ELyvthaTNTYWhEXc18SmuDs6ilRsQ8yKlNtqIf0kmVz/gTzMMg7PFlpeDuf8L
dKMVxwSHjXDfHV21VqaIfNt0+jZyjZl9yY1uzbQsSFzE9FRo2JMGX0sMnfYq3ZO+
+Ok6qPX8XCwXuASLzS/UEI7fb4o6UCGaSkrobUQjJqsWKZwvK9b0Kajsnzf1se6F
3VJXfRiGNf9tSb5abi0Ho6xxqNdMqXGs0NCRk1CXZmbgSBBW7s0rr7rQNstVW+4K
c1XcbVFA7WSLQxgYU4T7+vtpAVWU22NBOsQvWS382n2p4hw/wUUCopW8CenvSRpp
LjrrPDDh7VZqdZkQrWrpF9oVV+FHPm2Fu+iY9+GROPOwIWKj4HM=
=B+Iq
-----END PGP SIGNATURE-----

--nextPart381516546.hc3ZE7W9pX--



