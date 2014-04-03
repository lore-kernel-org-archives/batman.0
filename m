Return-Path: <martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Date: Thu, 03 Apr 2014 14:27:31 -0700
From: martin@hundeboll.net
In-Reply-To: <CANMu=jLm6K=p_ADAGAVRzjvGmrF++DxukccEc6bK7+FV5XQchg@mail.gmail.com>
References: <CANMu=jLm6K=p_ADAGAVRzjvGmrF++DxukccEc6bK7+FV5XQchg@mail.gmail.com>
Message-ID: <ba49bf69fcbe032f231d5c5c2b4ebd97@hundeboll.net>
Subject: Re: [B.A.T.M.A.N.] Mixing non-B.A.T.M.A.N. systems with batman-adv
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
To: =?UTF-8?Q?Dimar_Jaime_Gonz=C3=A1lez_Soto?= <dimar.gonzalez.soto@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

Hi Dimar,

Please direct your question to the batman mailing list instead of 
directly to me. That way, you can get help from a lot more people, and 
also get help if I didn't have time to answer...

Nevertheless, I replied inline below.

On 2014-04-03 14:16, Dimar Jaime González Soto wrote:
> Hi Martin,  I need to connect to my mesh network with non b.a.t.m.a.n
> nodes(specifically a tablet).   I followed the instructions
> from http://www.open-mesh.org/projects/batman-adv/wiki/Quick-start-guide
> [1] and I configured a node creating a mesh-bridge interface.  The
> interface, I think, allow the connection through eth0, but the what I
> want is a connection trough the wireless interface, and i don't know
> how to setup the network.

I am a little confused about your current setup. Can you please send us 
(that is the batman mailing: b.a.t.m.a.n@lists.open-mesh.org), the 
following information:

The output of "ip link"
The output of "batctl if"
The output of "brctl show"

That will make it possible for us to give you better information.

Thanks,
Martin
