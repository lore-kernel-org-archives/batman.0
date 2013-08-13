Return-Path: <gui@altermundi.net>
Message-ID: <520984DC.7040401@altermundi.net>
Date: Mon, 12 Aug 2013 21:59:08 -0300
From: Gui Iribarren <gui@altermundi.net>
MIME-Version: 1.0
References: <5209814D.3020506@wirelesspt.net>
In-Reply-To: <5209814D.3020506@wirelesspt.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [OpenWrt-Devel] Kernel panic & Process batadv.sh
	- Fatal
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
To: cmsv@wirelesspt.net, OpenWrt Development List <openwrt-devel@lists.openwrt.org>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On 08/12/2013 09:43 PM, cmsv wrote:
> OpenWrt version: Attitude Adjustment (r37747)
>
> Recently there was someone (Lucaspost) on #batman with a problem caused
> by mixing the latest AA and Batman-adv 2013.3.0 and while i can't be
> sure the problem is exactly this one; here goes my testing with a D-link
> 615C1
>

maybe you're mixing module and kernel versions?

try to "make dirclean" and rebuild

batadv.sh only does this

echo "$mesh" > "/sys/class/net/$iface/batman_adv/mesh_iface"

where $iface is something like "wlan0" and $mesh is "bat0"

HTH,

Gui
