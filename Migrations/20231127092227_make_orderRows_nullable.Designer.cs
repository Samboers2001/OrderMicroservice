﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using OrderMicroservice.Data;

#nullable disable

namespace OrderMicroservice.Migrations
{
    [DbContext(typeof(AppDbContext))]
    [Migration("20231127092227_make_orderRows_nullable")]
    partial class make_orderRows_nullable
    {
        /// <inheritdoc />
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "7.0.13")
                .HasAnnotation("Relational:MaxIdentifierLength", 64);

            modelBuilder.Entity("OrderMicroservice.Models.Order", b =>
                {
                    b.Property<int>("OrderId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<DateTime>("Created")
                        .HasColumnType("datetime(6)");

                    b.Property<string>("CustomerId")
                        .IsRequired()
                        .HasColumnType("longtext");

                    b.HasKey("OrderId");

                    b.ToTable("Orders");
                });

            modelBuilder.Entity("OrderMicroservice.Models.OrderRow", b =>
                {
                    b.Property<int>("OrderRowId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<DateTime>("Created")
                        .HasColumnType("datetime(6)");

                    b.Property<int>("OrderId")
                        .HasColumnType("int");

                    b.Property<decimal>("Price")
                        .HasColumnType("decimal(65,30)");

                    b.Property<int>("ProductId")
                        .HasColumnType("int");

                    b.Property<int>("Quantity")
                        .HasColumnType("int");

                    b.HasKey("OrderRowId");

                    b.HasIndex("OrderId");

                    b.ToTable("OrderRows");
                });

            modelBuilder.Entity("OrderMicroservice.Models.Product", b =>
                {
                    b.Property<int>("ExternalProductId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<DateTime>("Created")
                        .HasColumnType("datetime(6)");

                    b.HasKey("ExternalProductId");

                    b.ToTable("Products");
                });

            modelBuilder.Entity("OrderMicroservice.Models.OrderRow", b =>
                {
                    b.HasOne("OrderMicroservice.Models.Order", "Order")
                        .WithMany("OrderRows")
                        .HasForeignKey("OrderId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Order");
                });

            modelBuilder.Entity("OrderMicroservice.Models.Order", b =>
                {
                    b.Navigation("OrderRows");
                });
#pragma warning restore 612, 618
        }
    }
}
