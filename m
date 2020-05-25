Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
MIME-Version: 1.0
References: <CAOVt3fEEaLx8-58NjVXU0L6XToB5FPvGjFaEoZBeRCL+Eh-QWw@mail.gmail.com>
 <4309595.MtDqpTPQ1e@rousseau> <CAOVt3fEbtq-9aR-p-uEhukb+sdWduay3WfZi6GpwtdVdZpe=vQ@mail.gmail.com>
 <10714145.5AxrDinkzN@rousseau>
In-Reply-To: <10714145.5AxrDinkzN@rousseau>
From: Alexey Ermakov <axel101@gmail.com>
Date: Mon, 25 May 2020 20:21:50 +0300
Message-ID: <CAOVt3fGODcxuZAigHuHSgPED5Y67kB2NV2encCyDz4qMFy7gyQ@mail.gmail.com>
Subject: Re: Batman-adv packet retranslation
Content-Type: text/plain; charset="UTF-8"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

> I am surprised you still are configuring a throughput override of 100kbit/s.
> What's the idea behind this configuration ?

I have two channels between nodes (actually more, but this doesn't matter now)
1) Radio modem, connects as follows:
   NODE1(eth0)<-->modem(radio)<-->(radio)modem<-->(eth0)NODE2
eth0 interface have 100mbit/s speed and batman detects it as 100mbit/s.
radio has 145kbit/s, and actual speed of this channel is 145kbit/s

2) eth1 Ethernet channel. Speed of this channel is 100mbit/s
   NODE1(eth1)<---->(eth1)NODE2

Now make a test:
1) Set up eth0 modem channel
2) Disconnect eth1 channel
3) Turn on nodes - batman saw eth0 channel between nodes and detected
speed 100mbit/s (because speed between node and modem is 100mbit/s, as
I understand)
4) plug eth1 cable in - At this moment I expect batman switch to eth1
channel because it has real 100mbit/s speed. But batman doesn't
switch, because it detects eth0 as 100mbit/s too.
Therefore I override throughput of eth0, actually batman detects
incorrect speed on eth0.
