Return-Path: <fboehm@aon.at>
Message-ID: <53023C90.2030904@aon.at>
Date: Mon, 17 Feb 2014 17:45:04 +0100
From: fboehm <fboehm@aon.at>
MIME-Version: 1.0
References: <53022AD7.5030200@tu-bs.de>
In-Reply-To: <53022AD7.5030200@tu-bs.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] batman-adv  and 802.xx
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

Am 17.02.14 16:29, schrieb Harms, Hannes:
>
> Dear list,
>
> I have a problems to understand whre are the borders of batman-adv.
> For exampel if I use enddvices that support 802.n, I will achive a
> higher throughput than with 802.g devices.
> I tested this in practice.
> But what happens if I use devices that support 802.ac ?
> Will the throughput also be higher in my network, and would the devices
> use beamforming?
> I assume that all devices in the network are the same.
>
> Best regrads and thanks for your time
> Hannes
>
>
>
Features that control/improve the throughput like beamforming or 
rate-control aren't influenced by batman-adv. Those are features inside 
the wireless driver. Just between batman-adv and the PHY-Layer in the 
network stack.

I might not have enough experience with 802.11ac devices but if you have 
a large scale outdoor network with big distances between your nodes 
(hundreds of meters to kilometers) there might be not a big difference 
between 802.11ac and 802.11n.

But if it's a smaller scale indoor network with lower distances and 
lower noise floor there should be a higher throughput with 802.11ac.

Kind regards,
Franz
