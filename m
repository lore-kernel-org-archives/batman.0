Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 20 Mar 2018 02:09:35 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20180320010935.GE1798@otheros>
References: <5aaf0fb1c41b_2bda2abf4cb1af68668dc@node1.mail>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5aaf0fb1c41b_2bda2abf4cb1af68668dc@node1.mail>
Subject: Re: [B.A.T.M.A.N.] New Defects reported by Coverity Scan for batctl
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

On Mon, Mar 19, 2018 at 01:17:37AM +0000, scan-admin@coverity.com wrote:
[...]
> ________________________________________________________________________________________________________
> *** CID 174547:  Incorrect expression  (COPY_PASTE_ERROR)
> /netlink.c: 255 in info_callback()
> 249     		else
> 250     			mcast_flags = -EOPNOTSUPP;
> 251     
> 252     		if (attrs[BATADV_ATTR_MCAST_FLAGS_PRIV])
> 253     			mcast_flags_priv = nla_get_u32(attrs[BATADV_ATTR_MCAST_FLAGS_PRIV]);
> 254     		else
> >>>     CID 174547:  Incorrect expression  (COPY_PASTE_ERROR)
> >>>     "mcast_flags" in "mcast_flags = -95L" looks like a copy-paste error.
> 255     			mcast_flags = -EOPNOTSUPP;
[...]

Now this is officially the second time a code/patch reviewing
algorithm creeps me out :D.

"Looks like", yeah... and even worse, the AI is actually right...
I will send a fix :).

Cheers
