Return-Path: <onelektra@gmx.net>
From: elektra <onelektra@gmx.net>
Date: Thu, 27 Aug 2009 13:10:33 +0200
References: <20090826064151.GE21827@ma.tech.ascom.ch>
	<200908261119.22173.onelektra@gmx.net>
	<20090826180810.GF16067@lunn.ch>
In-Reply-To: <20090826180810.GF16067@lunn.ch>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200908271310.34348.onelektra@gmx.net>
Subject: Re: [B.A.T.M.A.N.] List policy for none subscribers
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

Hi!

> How many of these goals can be reached without changing the packet
> format? I've implemented regenerating lost OGMs without changing the
> protocol to a degree it needs to bump the version number. Does
> removing the averaging of TQ from remote neighbors change the message
> format?

We were discussing about including local Hello messages in the design, so 
there will be a additional packet type. Hmm. 
Maybe we could go without breaking backward compatibility. On the other hand - 
why should we not break backward compatibility when we introduce a new 
generation of the protocol? Running old and new together may introduce 
'interesting' side effects and we'll eventually find ourself debugging 
incompatibility problems when trying to trace bugs in the new protocol 
version. Hence we have decided to add a compatibility version number in the 
packets at a very early stage of the project.

Regarding a open posting list - what would be a possible migration scenario 
for a new list hosted at sourceware et al, given that we have an existing list 
with a number of subscribers? 

Cheers,
Elektra
