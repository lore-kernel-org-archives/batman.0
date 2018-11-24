Return-Path: <jiri@resnulli.us>
Date: Sat, 24 Nov 2018 10:29:55 +0100
From: Jiri Pirko <jiri@resnulli.us>
Message-ID: <20181124092955.GA2511@nanopsycho.orion>
References: <20181123161359.13342-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123161359.13342-1-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [RFC v2 00/19] batman-adv: netlink restructuring, part 2
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org

Fri, Nov 23, 2018 at 05:13:40PM CET, sven@narfation.org wrote:
>Hi,
>
>Jiri Pirko called the batman-adv configuration interface a while back "a
>huge mistake" [1] and suggested genl as alternative. The first
>reimplementation [2] (based on the team/devlink design) was rejected. This
>second implementation is now using a nl80211-like design. The objects
>which can now be modified/queried are:
>
>* mesh/soft-interface (BATADV_CMD_GET_MESH/BATADV_CMD_SET_MESH)
>* slave/hard-interface (BATADV_CMD_GET_HARDIF/BATADV_CMD_SET_HARDIF)
>* vlan (BATADV_CMD_GET_VLAN/BATADV_CMD_SET_VLAN)
>
>Such a set messages automatically triggers a *_SET_* "reply" via the config
>multicast group. The same behavior was also added to the sysfs interface.
>
>Luckily, Jiri Pirko told us that he will have a look at patches. I would
>also like to ask the other developers to check whether their configuration
>values are represented correctly. And please also check whether the current
>implementation might collide with some other features which you might have
>in your pipeline.
>
>v2:
>* rewrite everything in a more nl80211-like message/attribute format.
>
>Kind regards,
>        Sven


This looks great. Nice job!

Do you have a userspace app to communicate with this? Would be nice to
play with it or at least to see examples of usage.

Thanks!
