Return-Path: <panayot.daskalov@gmail.com>
Message-ID: <4EC9766D.9000302@gmail.com>
Date: Sun, 20 Nov 2011 23:51:41 +0200
From: Panayot Daskalov <panayot.daskalov@gmail.com>
MIME-Version: 1.0
References: <4EC967CC.1040804@gmail.com> <20111120210326.GA3080@ritirata.org>
	<20111120211558.GA11262@autistici.org>
In-Reply-To: <20111120211558.GA11262@autistici.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Connecting non-batman nodes to a mesh network
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Hi Antonio,

thanks for the prompt reply!

The devices have either RTL8188SU or RTL8188CUS chipsets from Realtek. 
Drivers can be found here -
http://www.realtek.com.tw/downloads/downloadsView.aspx?Langid=1&PNid=48&PFid=48&Level=5&Conn=4&DownTypeID=3&GetDown=false&Downloads=true#RTL8188SU 
<http://www.realtek.com.tw/downloads/downloadsView.aspx?Langid=1&PNid=48&PFid=48&Level=5&Conn=4&DownTypeID=3&GetDown=false&Downloads=true#RTL8188SU>

May be they are mac80211 compatible, but I am not sure. Can you give me 
an example of creating a virtual interface so I can try?

Thanks.

Best regards,
Panayot

On 11/20/2011 11:16 PM, Antonio Quartulli wrote:
> On dom, nov 20, 2011 at 10:49:16 +0200, Panayot Daskalov wrote:
>>> Hi All,
>>>
>>> I want to ask for your advice about a batman problem I am facing. I have
>>> a mesh network of custom build embedded Linux devices. The devices have
>>> only network one interface and this is the Wi-Fi that is used by batman.
>>> So far the mesh is running OK, but at some point I need to be able to
>>> connect with a laptop (non-Linux) to the network and access some of the
>>> devices via its IP address. I tried simply connecting to the adhoc
>>> network and setting a static IP to my laptop. I have managed to do that,
>>> but I can't access the nodes from the mesh.
>>>
>>> I read the instruction for mixing with non-batman devices by bridging
>>> the bat0 interface with the "non-batman" interface, but as far as I
>>> understand that applies to systems with at least 2 network interfaces
>>> e.g one for batman nodes and one for the non-batman. So my question is -
>>> can I mix non-batman and batman nodes when I have only one network
>>> interface on the batman nodes? If yes, then how?
>   Hi Panayot,
>
>   you are right: you need two "interfaces" in order to let clients connect
>   to the mesh. However (if you want to use wifi interfaces only) you can
>   also create "virtual interaces" using the same "real interface". This
>   feature is available depending on the wifi driver you are using. If you are
>   using madwifi or one of the new mac80211 drivers (not all support it),
>   this technique should be feasiable without introducing many problems :)
>
>   For instance, what driver are you using?
>
>   Cheers,
>

