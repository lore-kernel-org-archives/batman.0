Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Date: Wed, 24 Mar 2021 14:27:21 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: Re: Batman adv selective broadcast mechanism
Message-ID: <20210324132721.GC2174@otheros>
References: <20210324121616.1198.15914@diktynna.open-mesh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210324121616.1198.15914@diktynna.open-mesh.org>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi,

On Wed, Mar 24, 2021 at 12:16:16PM -0000, oytunyapar@hotmail.com wrote:
> Hi everybody,
> 
>     As I check, batman-adv protocol, sends IP broadcast packets, to every slave interface, including the slave interface from which the broadcast packet is received. Is there any way for preventing the batman-adv from sending IP broadcast packets to some of the slave interfaces (etc. the one which the packet is received)?

When there is just a single neighbor on the interface a node
received the packet on that batman-adv avoids sending it
back automatically. E.g. this case here:

https://www.open-mesh.org/projects/batman-adv/wiki/Broadcast#IIII-Single-Neighbor-Is-Previous-Sender

If there are multiple neighbors on the receiving interface then
batman-adv assumes that other neighbors might potentially not have
received the packet from the original sender. And will therefore
rebroadcast on the incoming interface, too.

If you are 100% sure that all other neighbors received it from
the original sender then there is this old patch which isn't
upstream though (including the discussion with why it was
rejetected for upstream):

https://patchwork.open-mesh.org/project/b.a.t.m.a.n./patch/1380030033-11533-1-git-send-email-linus.luessing@web.de/

Regards, Linus
