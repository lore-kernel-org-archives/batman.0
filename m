Return-Path: <linus.luessing@c0d3.blue>
Date: Fri, 4 Jan 2019 02:53:42 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20190104015342.GF21623@otheros>
References: <20181207135846.6152-1-sven@narfation.org>
 <20181207135846.6152-5-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181207135846.6152-5-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [RFC v3 04/19] batman-adv: Prepare framework for
 vlan genl config
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




On Fri, Dec 07, 2018 at 02:58:31PM +0100, Sven Eckelmann wrote:
> The batman-adv configuration interface was implemented solely using sysfs.
> This approach was condemned by non-batadv developers as "huge mistake".
> Instead a netlink/genl based implementation was suggested.
> 
> Beside the mesh/soft-interface specific configuration, the VLANs on top of
> the mesh/soft-interface have configuration settings. The genl interface
> reflects this by allowing to get/set it using the vlan specific commands
> BATADV_CMD_GET_VLAN/BATADV_CMD_SET_VLAN.
> 
> The set command BATADV_CMD_SET_MESH will also notify interested userspace
> listeners of the "config" mcast group using the BATADV_CMD_SET_VLAN command
> message type that settings might have been changed and what the current
> values are.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---

Looks good.

Initially I was a bit confused with batadv_pre_doit() and
thought you were missing to free the hard_iface in the
"if (IS_ERR(vlan))" case. But then I remembered your initial
WARN_ON() which ensures that hardif and vlan are exclusive.
