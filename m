Return-Path: <andrew@lunn.ch>
Date: Sun, 6 Mar 2016 15:10:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160306141044.GD1976@lunn.ch>
References: <1457190564-11419-1-git-send-email-sven@narfation.org>
 <20160306000823.GB1976@lunn.ch> <1718376.7aKDD05sGf@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1718376.7aKDD05sGf@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/9] batman-adv: Check hard_iface refcnt
 before calling function
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
Cc: b.a.t.m.a.n@lists.open-mesh.org

> And a small remark about your x86 without serial port. Two systems connected 
> via usb-serial+null-model-cable+usb-serial work quite well for this type of 
> tests. Add  "console=tty0 console=ttyUSB0,115200,n8" to the bootargs of your 
> test system and boot it up. The system used for gathering the kernel output 
> just has to run "screen /dev/ttyUSB0 115200" and dump all the data.

Hi Sven

The box does have a couple of FTDI chips. But i've had mixed results
with such a setup. Often the Opps does not get out of the USB
subsystem before the box is dead. I can give it a try and see what
happens in this case.

	Andrew

