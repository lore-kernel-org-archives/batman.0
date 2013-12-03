Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 3 Dec 2013 11:54:37 +0100
References: <1386013113-25471-1-git-send-email-sw@simonwunderlich.de>
 <1386013113-25471-3-git-send-email-sw@simonwunderlich.de>
 <529CEA90.3010709@meshcoding.com>
In-Reply-To: <529CEA90.3010709@meshcoding.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201312031154.37297.sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH-next 3/4] batman-adv: fix size of
	batadv_icmp_header
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

Hey Antonio,

> On 02/12/13 20:38, Simon Wunderlich wrote:
> > struct batadv_icmp_header { uint8_t  packet_type; @@ -208,18
> > +211,16 @@ struct batadv_icmp_header { uint8_t  dst[ETH_ALEN];
> > uint8_t  orig[ETH_ALEN]; uint8_t  uid; +	uint8_t  rr_cur; +	__be16
> > seqno; };
> 
> seqno was not in the header on purpose because new features may need a
> larger seqno space (e.g. the bw meter uses 32bits long seqnos).
> I think we have to re-work this structure differently..

ah ok, didn't know that. Well I also thought to move that uid into the other 
structures to have the icmp header at 16 bytes, but then we need to access the 
icmp_packet instead of icmp_header in functions like batadv_socket_write() - I 
changed that just recently. ;)

What do you suggest? These new types can't work with 16bit seqnos? :)
> 
> rr_cur was not in the header because it is only used by the PING and
> not by all the others ICMP packets. But having it in the header is
> harmless I think.

Yeah, agreed.

Cheers,
    Simon
