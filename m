Return-Path: <andrew@lunn.ch>
Date: Sun, 20 Aug 2017 16:05:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20170820140507.GA24150@lunn.ch>
References: <CAA_JP8UHmeHu_UavyVt9tXQ27AVOdNcznZnuCib3xoSDB0V8Tw@mail.gmail.com>
 <5468456.iLjU66Egku@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5468456.iLjU66Egku@sven-edge>
Subject: Re: [B.A.T.M.A.N.] wired performance
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

> And there is currently no special batman-adv support for the flow 
> dissector [1] in the kernel. This could be also a reason why multiple flows 
> are not distributed well to different cores when you enable RPS/XPS. It is not 
> yet know whether this will actually be helpful but at least someone interested 
> could do same research and implement a proof-of-concept patches for further 
> testing.

Hi Sven

DSA just added a patch to help with flow dissectors. Maybe it can be
generalized and made to work for BATMAN as well?

commit 43e665287f931a167cd2eea3387efda901bff0ce
Author: John Crispin <john@phrozen.org>
Date:   Wed Aug 9 14:41:19 2017 +0200

    net-next: dsa: fix flow dissection
    
    RPS and probably other kernel features are currently broken on some if not
    all DSA devices. The root cause of this is that skb_hash will call the
    flow_dissector. At this point the skb still contains the magic switch
    header and the skb->protocol field is not set up to the correct 802.3
    value yet. By the time the tag specific code is called, removing the header
    and properly setting the protocol an invalid hash is already set. In the
    case of the mt7530 this will result in all flows always having the same
    hash.
