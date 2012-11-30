Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 30 Nov 2012 10:41:12 +0800
References: <CALDpWg5UxkqP2_f-waB===fDPHg6vC0xf8=oxVx7aH5XvXd6uQ@mail.gmail.com>
 <CALDpWg5uoeERLHMawtLP5F5EC9Xvkyf5WAu7DVYwOXDw3fwfYw@mail.gmail.com>
 <CALDpWg6Ci0DDUs=Y8TKWn98uwLXnhG1Mdb5NEje1jdvJJoiFdA@mail.gmail.com>
In-Reply-To: <CALDpWg6Ci0DDUs=Y8TKWn98uwLXnhG1Mdb5NEje1jdvJJoiFdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201211301041.12227.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv: Raw Socket Communication
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


Hi,

> By looking at the packet.h from the batctl source code. I found this:
> 
> #define BATADV_ETH_P_BATMAN  0x4305 /* unofficial/not registered Ethertype
> */
> 
> I guess it would be the packet type batman would recognized. When I
> set the type to 0x4305.
> However, I cannot even see any output from the receiver side when I
> run batctl tcpdump bat0 on it.

you apparently have misunderstood the meaning of "batctl does not know your 
packet type". Even if you used wireshark or tcpdump or any other packet dump 
analyzer - nobody knows your packet because you just made it up yourself!

Now comes the funny part: Nobody needs to know your packet type except for 
your application! As long as your application can read what you are sending 
you are good.

If you have more questions I urge you to join our IRC channel (#batman on 
freenode) and continue the discussion there. You seem to be confused about 
what is going on.

Cheers,
Marek
