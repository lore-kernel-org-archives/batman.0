Return-Path: <andrew@lunn.ch>
Date: Wed, 12 Nov 2014 16:31:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20141112153130.GC10957@lunn.ch>
References: <CAEbDFcT3xFoJee3LFDxXEazJ1QS4DCkzoUSFipC6HAudHZ+O-Q@mail.gmail.com>
 <20141112042905.GB31881@lunn.ch>
 <CAEbDFcSO7RpyBmVmXk9dbfiLpQ8srbrHgksCtkDRB_9iAifWCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEbDFcSO7RpyBmVmXk9dbfiLpQ8srbrHgksCtkDRB_9iAifWCQ@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Tcp filtering in batman-adv
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Wed, Nov 12, 2014 at 11:06:51AM +0530, Krishnathiepan Rasanayagam wrote:
> Hi Andrew,
> 
> i don't understand you, can you rephrase it?

http://tldp.org/HOWTO/Traffic-Control-HOWTO/index.html

This is the normal way to do QoS within Linux. You can do traffic
shaping, scheduling, policing, etc. I've not tried it, but you should
be able to apply tc commands to both the soft interface, bat0, and the
hard interface, wlan0.

Now you seem to be saying you want to do QoS in the middle of BATMAN.
Why? What can you do in the middle, which TC cannot do?

     Andrew
