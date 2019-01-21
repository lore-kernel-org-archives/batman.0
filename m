Return-Path: <jiri@resnulli.us>
Date: Mon, 21 Jan 2019 10:47:16 +0100
From: Jiri Pirko <jiri@resnulli.us>
Message-ID: <20190121094716.GD2228@nanopsycho>
References: <20190119155626.6414-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190119155626.6414-1-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [RFC v4 00/19] batman-adv: netlink restructuring, part 2
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

Sat, Jan 19, 2019 at 04:56:07PM CET, sven@narfation.org wrote:
>Hi,
>
>Jiri Pirko called the batman-adv configuration interface a while back "a
>huge mistake" [1] and suggested genl as alternative. The first
>reimplementation [2] (based on the team/devlink design) was rejected. This
>second implementation is now using a nl80211-like design. The objects which
>can now be modified/queried are:
>
>* mesh/soft-interface (BATADV_CMD_GET_MESH/BATADV_CMD_SET_MESH)
>* slave/hard-interface (BATADV_CMD_GET_HARDIF/BATADV_CMD_SET_HARDIF)
>* vlan (BATADV_CMD_GET_VLAN/BATADV_CMD_SET_VLAN)
>
>Such a set messages automatically triggers a *_SET_* "reply" via the config
>multicast group. The same behavior was also added to the sysfs interface.

In general aside of couple of nits I described, this iteration of
the patchset looks very nice to me. Thanks!
