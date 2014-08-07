Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 7 Aug 2014 18:04:32 +0200
References: <53E390D5.10009@jluehr.de>
In-Reply-To: <53E390D5.10009@jluehr.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201408071804.32979.sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] Running alfred as non-root user?
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

> Hello,
> 
> everytime I try to start alfred 2014.3.0 using a dedicated non-root user
> it fails with: can't bind unix socket: Address already in use
> 
> Running as root is successful. Is it possible to start alfred as non-root?

You are most probably having another alfred instance already running? 
Otherwise you should get "permission denied" or something.

In any case, even if you have the sufficient rights, alfred also needs to bind 
to the interface which is only possible as superuser. We currently don't 
support running alfred as non-root. If someone is interested in that and know 
how to support that while maintaining all current features, I'd be looking 
forward to patches. :)

Cheers,
     Simon
