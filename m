Return-Path: <MAILER-DAEMON>
Subject: Re: How to give stable MAC address to batman-adv device?
References: <3af7c293-5b8c-535c-2049-eef51b36da81@exon.name>
 <2134316.j67oi4WX0K@sven-edge>
From: batman.mexon@spamgourmet.com
Message-ID: <67a3f347-0734-1a63-b858-1c80b0774322@exon.name>
Date: Sun, 1 Sep 2019 17:52:35 +0200
MIME-Version: 1.0
In-Reply-To: <2134316.j67oi4WX0K@sven-edge>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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

On 2019-09-01 08:42 , Sven Eckelmann - sven@narfation.org wrote:
> On Saturday, 31 August 2019 21:33:09 CEST batman.mexon@spamgourmet.com wrote:
>> I'm trying to use batman-adv to fix wifi signal problems with a few
>> Raspberry Pis.
> batman-adv doesn't change your wifi signal. So I am assuming that your main 
> access point wasn't able to cover the whole area and so you use multiple 
> accesspoint and use mesh as a backbone between them.


Not quite.  It's just that the most distant raspberry pi can't reach the
main access point, so I want it to automatically find a closer raspberry
pi to act as a relay.  But yeah you're right I'm not trying to improve
the signal itself, just work around what I've got.

>
> [...]
>> Is there a way to force batman-adv to use a stable MAC address?
>     ip link set dev bat0 address XX:XX:XX:XX:XX:XX
>
> There might be a configuration option in whatever configuration interface you 
> use to bring up the interfaces.
>
Hey yeah, that's exactly what I'm after, thanks!  I'm not sure I've
quite got it working exactly right, I'll have to see if leases still get
renewed correctly.  But that command is definitely what I needed.

