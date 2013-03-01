Return-Path: <mihail.costea90@gmail.com>
MIME-Version: 1.0
Date: Fri, 1 Mar 2013 12:59:18 +0200
Message-ID: <CAP5XTDP_8pCJA8uXpQoMNExiVaCvmBCmkKT_aDErk0qYk7-pmw@mail.gmail.com>
From: Mihail Costea <mihail.costea90@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] Implement DAT for IPv6
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hi,

I've started implementing DAT for IPv6 and I have a few questions
regarding the design.
I've already implemented a snooping mechanism for Network Solicitation
package, but now I have to add it to the ipv6 distributed table.
I'm also a beginner in kernel programming so any help would be useful.

From what I've seen there is a lot of code in distributed-arp-table.c
that could be used for ipv6 distributed table.
A problem in using that code, from what I've seen, is the fact that
<struct batadv_dat_entry > has a field for ip with only 32 bits
(__be32).

So I was thinking to make it more general by:
1. transforming that into a pointer (unsigned char *ip) and add a
field size which will represent the total size of the ip.
The ip itself would be allocated dynamically.
2. use a union with both _be32 / struct in6_addr. In this case the
problem is that if we use ipv4 then all the other space for struct
in6_addr would be wasted.

The second problem from what I've seen in the code is that the
batadv_priv->dat field is hardcoded.
For ipv6 we would need a new field to memorize the table, but I don't
think it's a really hard problem to solve in order to make it general.

This solution would be to avoid code duplicate. Off course, I could
still write all the code in parallel just for IPv6, but I think that a
common base would be useful.

Thanks,
Mihail
