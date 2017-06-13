Return-Path: <joe@perches.com>
Message-ID: <1497390701.18751.26.camel@perches.com>
From: Joe Perches <joe@perches.com>
Date: Tue, 13 Jun 2017 14:51:41 -0700
Content-Type: text/plain; charset="iso-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] Odd use of %14pM in
 net/batman-adv/distributed-arp-table.c
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>
Cc: "David S. Miller" <davem@davemloft.net>, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

An output mac address is 17 bytes

         1
12345678901234567
00:11:22:33:44:55

but in net/batman-adv/distributed-arp-table.c

int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset)
{
[...]
			seq_printf(seq, " * %15pI4 %14pM %4i %6i:%02i\n",
				=A0=A0=A0&dat_entry->ip, dat_entry->mac_addr,
				=A0=A0=A0batadv_print_vid(dat_entry->vid),
				=A0=A0=A0last_seen_mins, last_seen_secs);

%14pM is odd as this should not emit the last byte of the
mac address.  So given the example above, it would output
00:11:22:33:44

Is that what's really desired?

If so, I'd suggest using something more obvious like %5phC

