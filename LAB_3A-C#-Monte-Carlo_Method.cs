

////1. Because we were only throwing darts into the top right corner (1/4 of circle)
////2. greater accuracy
////3. No, random numbers
////4. 100,000,000
////5. Within 1.0
////6. See below
///
/// using System;

//using CenterSpace.NMath.Core;

//namespace CenterSpace.NMath.Core.Examples.CSharp
//{
//    /// <summary>
//    /// A .NET example in C# showing how to calculate an approximation for Pi using a Monte
//    /// Carlo method and the uniform random number generator class RandGenUniform.
//    /// 
//    /// Imagine a 2 x 2 square with corners at (1,1), (1,-1), (-1,-1) and (-1,1)
//    /// and a unit circle, centered on the origin, inscribed within it. Generate 
//    /// random points inside the square and let M be the number of points
//    /// that fall within the unit circle and N be the total number of points
//    /// generated. As the number N gets large, the quantity M/N should approximate the 
//    /// ratio of the area of the circle to the square, which is pi/4. Hence, we can
//    /// use the ratio 4*M/N to approximate Pi.
//    /// </summary>
//    class MonteCarloRNGExample
//    {

//        static void Main(string[] args)
//        {
//            // Construct a random number generator that generates random deviates
//            // distributed uniformly over the interval [-1,1]
//            var rng = new RandGenUniform(-1.0, 1.0);

//            // We'll approximate pi to within 5 digits.
//            double tolerance = 1e-5;

//            double piApproximation = 0;
//            int total = 0;
//            int numInCircle = 0;
//            double x, y; // Coordinates of the random point.

//            // Generate random points until our approximation within
//            // the desired tolerance.
//            while (Math.Abs(Math.PI - piApproximation) > tolerance)
//            {
//                x = rng.Next();
//                y = rng.Next();
//                if (x * x + y * y <= 1.0) // Is the point in the circle?
//                {
//                    ++numInCircle;
//                }
//                ++total;
//                piApproximation = 4.0 * ((double)numInCircle / (double)total);
//            }

//            Console.WriteLine();

//            Console.WriteLine("Pi calculated to within {0} digits with {1} random points.",
//              -Math.Log10(tolerance), total);
//            Console.WriteLine("Approximated Pi = {0}", piApproximation);

//            Console.WriteLine();
//            Console.WriteLine("Press Enter Key");
//            Console.Read();
//        }
//    }// class

//}// namespace
using System;

namespace MonteCarlo_Method
{
    class Program
    {
        static void Main(string[] args)
        {
            
            runSimulation (100);
        }
        static double Hypotenuse(double x, double y)
        {
            double hypotenuse;
            hypotenuse = Math.Sqrt(Math.Pow(x, 2) + Math.Pow(y, 2));
         
            return hypotenuse;

        }
        static void runSimulation(int maxIterations)
        {
           
            int iteration = 0;
            int inCircleCount = 0;
            double estimate;
            double delta;
           
            do
            {
                (double, double) pair = genPair();
                double hypotenuse = Hypotenuse(pair.Item2, pair.Item2);

                if (hypotenuse <= 1)
                {
                    inCircleCount++;

                }

                iteration++;
            } while (iteration < maxIterations);

            estimate = ((inCircleCount * 4.0)/ maxIterations);
            delta = Math.Abs(estimate - Math.PI);

            Console.WriteLine($"The Estimate Is:    {estimate}, \n The Different Is:    {delta}");
        }
        static (double, double) genPair()
        {
            Random rng = new Random();
            double randomNumberOne = rng.NextDouble();
            double randomNumberTwo = rng.NextDouble();

            (double, double) randomPair = (randomNumberOne, randomNumberTwo);
            return randomPair;

        }
    }
}
